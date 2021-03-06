# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{restafarian}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Britt"]
  s.date = %q{2013-07-05}
  s.default_executable = %q{restafarian}
  s.description = %q{A bit of Rack middleware to do REST routing}
  s.email = %q{james@neurogami.com}
  s.executables = ["restafarian"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "bin/restafarian"]
  s.files = [ "History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/restafarian", "lib/restafarian.rb", "lib/restafarian/restafarian.rb", "restafarian.gemspec" ]
  s.homepage = %q{http://neurogami.com/code/restafarian}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ }
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{A bit of Rack middleware to do REST routing}
  s.test_files = ["test/test_restafarian.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 2.5.0"])
    else
      s.add_dependency(%q<bones>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<bones>, [">= 2.5.0"])
  end
end
