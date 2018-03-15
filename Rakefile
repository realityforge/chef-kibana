# Encoding: utf-8
# frozen_string_literal: true

require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'bundler/setup'

require 'stove/rake_task'
Stove::RakeTask.new

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

desc 'Foodcritic linter'
task :foodcritic do
  sh 'foodcritic -f any -t ~FC007 .'
end

desc 'Run Test Kitchen integration tests'
namespace :integration do
  desc 'Run integration tests with kitchen-vagrant'
  task :vagrant do
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each { |instance| instance.test(:always) }
  end

  desc 'Run integration tests with kitchen-docker'
  task :docker, [:instance] do |_t, args|
    args.with_defaults(instance: 'default-ubuntu-1404')
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.docker.yml')
    instances = Kitchen::Config.new(loader: loader).instances
    # Travis CI Docker service does not support destroy:
    instances.get(args.instance).verify
  end
end

desc 'Run chefspec unit tests'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = [].tap do |a|
    a.push('--color')
    a.push('--format progress')
  end.join(' ')
  t.pattern = 'test/unit/spec/*_spec.rb'
end

task default: [:rubocop, :foodcritic, :unit]
