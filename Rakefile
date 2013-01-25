require 'rake'
require 'rake/testtask'

environment = ENV['RACK_ENV'] ||= 'development'

task :default => ["server"]

namespace :compile do
  desc 'Compile app/styles to /public/app.css'
  task :styles do
    system 'bundle exec compass compile'
  end

  desc 'Compile app/scripts to /public/app.js'
  task :scripts do
    system 'coffee -o public/scripts -c app/scripts'
  end

  task :all => [:styles, :scripts]
end

task :compile => ['clobber','compile:all']

desc 'start server'
task :server => ['compile:all'] do
  system 'bundle exec rerun --pattern *.rb -- rackup --port 4000'
end

# Download
desc 'Download jQuery'
file "public/vendor/jquery/jquery-min.js" do
  mkdir_p 'public/vendor/jquery'
  system 'curl -o public/vendor/jquery/jquery-min.js http://code.jquery.com/jquery-latest.min.js'
end

desc 'Download Underscore'
file "public/vendor/underscore/underscore-min.js" do
  mkdir_p 'public/vendor/underscore'
  system 'curl -o public/vendor/underscore/underscore-min.js http://documentcloud.github.com/underscore/underscore-min.js'
end

desc 'Download Backbone'
file "public/vendor/backbone/backbone-min.js" => ['public/vendor/underscore/underscore-min.js', 'public/vendor/jquery/jquery-min.js'] do
  mkdir_p 'public/vendor/backbone'
  system 'curl -o public/vendor/backbone/backbone-min.js http://documentcloud.github.com/backbone/backbone-min.js'
end

# rake generate
desc 'Generate a new project at dir=foo'
task :generate do
  # Generate the new 'dir' if it's not already created
  system "mkdir #{(ENV['dir'])}" unless File.exists?(ENV['dir'])
  # Archive the current HEAD to 'dir'
  system "git archive HEAD | (cd #{ENV['dir']} && tar -xvf -)"

  puts "\n *** A new project has been generated at: #{(ENV['dir'])} ***"
end

desc 'Run tests'
task :test do
  Rake::TestTask.new do |t|
    t.libs << 'test'
    t.pattern = 'test/*_test.rb'
  end
end

CLEAN   = FileList['.sass-cache']
CLOBBER = FileList['public/styles/**/*.css', 'public/scripts/**/*.js']

desc 'Remove any temporary products.'
task :clean do
  CLEAN.each { |fn| rm_r fn rescue nil }
end

desc 'Remove any generated file.'
task :clobber => [:clean] do
  CLOBBER.each { |fn| rm_r fn rescue nil }
end
