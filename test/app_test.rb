$:.unshift File.expand_path("./../../lib", __FILE__)
require 'bundler'
Bundler.require
require 'app'
require 'minitest/autorun'
require 'minitest/pride'

class IdeaBoxAppTest < Minitest::Test
  include Rack::Test::Methods

  def test_it_failse
    assert false
  end
end
