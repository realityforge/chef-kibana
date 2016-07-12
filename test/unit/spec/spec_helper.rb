# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '14.04',
  log_level: ::LOG_LEVEL
}.freeze
::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}.freeze

def stub_resources
end

at_exit { ChefSpec::Coverage.report! }
