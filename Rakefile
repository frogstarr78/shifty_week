require 'rubygems'
require 'rake'
require 'init'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "shifty_week"
    gem.summary = %q{Calculate dates based on a configurable first day of the week.}
    gem.description = %q{Calculate dates based on a configurable first day of the week. If you want
    the first day of the week to be Wednesday and the current calendar Year-Month are 2009-10,
    DateTime#week_days will return an array of DateTime objects which when formatted with "%Y-%m-%d %a" look like 
    ["2009-10-14 Wed", "2009-10-15 Thu", "2009-10-16 Fri", "2009-10-17 Sat", "2009-10-18 Sun", "2009-10-19 Mon", "2009-10-20 Tue"] }
    gem.email = "frogstarr78@gmail.com"
    gem.homepage = "http://github.com/frogstarr78/shifty_week"
    gem.authors = ["Scott Noel-Hemming"]
    gem.rdoc_options << '--main' << 'ShiftyWeek' << '--line-numbers'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

begin
  require 'reek/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "shifty_week #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
