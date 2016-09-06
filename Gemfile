source 'https://rubygems.org'

gem 'berkshelf'
gem 'stove'

group :test do
  gem 'rake',               '~> 11.2.2'
  gem 'test-kitchen',       '~> 1.10.2'
  gem 'foodcritic',         '~> 7.0.1'
  gem 'rubocop',            '~> 0.41.2'
  gem 'chefspec',           '~> 4.7.0'
  gem 'buff-extensions',    '~> 1.0.0'
end

group :vagrant do
  gem 'kitchen-vagrant',    '~> 0.20.0'
end

group :development do
  gem 'knife-cookbook-doc', '~> 0.7.0'
  gem 'kitchen-openstack'
  gem 'kitchen-transport-rsync'
end

group :integration_docker do
  gem 'kitchen-docker', '~> 2.3'
end
