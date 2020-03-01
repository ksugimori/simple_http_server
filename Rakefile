require "bundler/gem_tasks"
require "yard"

begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end

YARD::Rake::YardocTask.new do |t|
  t.files = ["lib/**/*.rb"]
end
