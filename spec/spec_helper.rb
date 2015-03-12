$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'bundler/setup'
require 'webmock/rspec'
require 'vcr'
require 'helper'
require 'ruby-stackoverflow'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.fail_fast = true
  config.order = 'random'
end
