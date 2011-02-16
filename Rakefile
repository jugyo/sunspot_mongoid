require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "aq1018-sunspot_mongoid"
    gem.summary = %Q{A Sunspot wrapper for Mongoid.}
    gem.description = %Q{A Sunspot wrapper for Mongoid that is like sunspot_rails.}
    gem.email = "jugyo.org@gmail.com aq1018@gmail.com"
    gem.homepage = "http://github.com/aq1018/sunspot_mongoid"
    gem.authors = ["jugyo", "aq1018"]
    gem.add_runtime_dependency "mongoid", ">= 0"
    gem.add_runtime_dependency "sunspot", ">= 1.1.0"
    gem.add_runtime_dependency "sunspot_rails", ">= 1.1.0"
    gem.add_development_dependency "shoulda", ">= 0"
    gem.add_development_dependency "rr", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sunspot_mongoid #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
