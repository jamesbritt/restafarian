# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.


begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end


ensure_in_path 'lib'
require 'restafarian'

task :default => 'spec:run'


Bones {
  #name  'catch-ng'
  #authors  'James Britt / Neurogami'
  #email  'james@neurogami.com'
  #url  'http://code.neurogami.com'
  #version  Neurogami::CatchNg::VERSION
  #readme_file  'README.md'
  #summary 'catch-ng is super bad.'


  name  'restafarian'
authors  'James Britt'
email  'james@neurogami.com'
url  'http:// neurogami.com/code/restafarian'
version  Neurogami::Rack::Restafarian::VERSION
# rubyforge.name = 'restafarian'

spec.opts << '--color'

}



# EOF
