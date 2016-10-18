# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

require 'support/matchers'

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '14.04'
}.freeze
::UBUNTU_1604_OPTS = {
  platform: 'ubuntu',
  version: '16.04'
}.freeze
::CENTOS_OPTS = {
  platform: 'centos',
  version: '6.0'
}.freeze
::CENTOS7_OPTS = {
  platform: 'centos',
  version: '7.0'
}.freeze

def stub_resources
end

at_exit { ChefSpec::Coverage.report! }
