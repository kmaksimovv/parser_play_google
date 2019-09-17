require 'webmock/rspec'
require './lib/google_play_service'
require 'sequel'
require "rspec_sequel_matchers"

require './db_conn'

RSpec.configure do |config|
  config.include RspecSequel::Matchers
end
