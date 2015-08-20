# Encoding: utf-8

require 'rake'
require 'rake/testtask'

# Rainbow require is due to incompatibilities between version of
# rubocop and rainbow breaking the build. May be able to be removed
# at some future time
require 'rainbow/ext/string'
require 'rubocop/rake_task'
desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

desc 'Foodcritic linter'
task :foodcritic do
  sh 'foodcritic -f any -t ~FC007 .'
end

task default: [:rubocop, :foodcritic]
