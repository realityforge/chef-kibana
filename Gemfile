# frozen_string_literal: true

source 'https://rubygems.org'

gem 'berkshelf'
gem 'stove'

group :test do
  gem 'buff-extensions'
  gem 'chefspec'
  gem 'foodcritic'
  gem 'rake'
  gem 'rubocop'
  gem 'test-kitchen'
end

group :vagrant do
  gem 'kitchen-vagrant'
end

group :development do
  gem 'kitchen-openstack'
  gem 'kitchen-transport-rsync'
  gem 'knife-cookbook-doc'
end

group :integration_docker do
  gem 'kitchen-docker'
end
