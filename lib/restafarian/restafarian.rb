require 'rack/utils'


# Experiment to see about restriction certain URLs based on HTTP request type, and
# auto-routing requests using HTTP request type.
# So, for example, a GET to controller/post will fail.  A POST to /controller becomes a call to ControllerClass#post
module Neurogami
  module Rack

    class Restafarian

      def to_rest_parts path
        path.sub! /^\//, ''
        path.sub! /\/$/, ''
        path.strip!
        return {:base => '', :args => [] }   if path.empty?
        parts = path.split('/')
        base = parts.shift
        { :base => base, :args => parts }
      end

      def initialize app, options = {}
        @app = app
        @restricted_endpoints = options[:restricted_endpoints] || %w(index create delete update )
        @mapping = options[:mapping] || { 'GET' => '', 
                                      'PUT' =>  'put',
                                      'POST' => 'post',
                                      'DELETE' => 'delete',
                                      'DEFAULT' => 'index' }
      end

      def restricted_path_call? path_segements
        return true if @restricted_endpoints.include?(path_segements[:base])
        path_segements[:args] && @restricted_endpoints.include?(path_segements[:args].last)
      end

      def set_x_request env
        params = ::Rack::Utils.parse_query(env["rack.input"].read, "&") || []
      rescue
        warn "Error? #{$!}"
      ensure
        env["rack.input"].rewind
        env['REQUEST_METHOD'] = params['X-REQUEST_METHOD'] || env['X-REQUEST_METHOD'] || env['REQUEST_METHOD'] 
      end

      def restatize env

        set_x_request env
        ## Allow for clients to pass psuedo request type via, say, a form field
        # and update the values passed to the end app
        path = env["PATH_INFO"].dup
        path_segements = to_rest_parts path

        have_restricted_path = restricted_path_call? path_segements

        # Do not allow direct calls to REST mappings
        message = "Path not allowed"
        return [403, {'Content-Type' => 'text/plain', 'Content-length' => message.size }, message  ]  if  have_restricted_path 
        action = @mapping[env['REQUEST_METHOD'].upcase] || 'index'

        segments = [path_segements[:base], action, path_segements[:args] ].flatten
        segments.delete_if{|a| a.strip.empty? } 

        new_path = '/' + segments.flatten.join('/')

        env['PATH_INFO']    = new_path.dup
        env["REQUEST_PATH"] = new_path.dup 
        env["REQUEST_URI"]  = new_path + ( env['QUERY_STRING'].to_s.strip.empty? ? '' : '?' + env['QUERY_STRING'].to_s.strip )

      end

      def call env
        restatize env  
        @app.call env
      end
    end

  end
end
