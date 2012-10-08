$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'gbwd'
require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include FakeFS::SpecHelpers, fakefs: true
end

