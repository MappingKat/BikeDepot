ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require './lib/server'

class ServerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    BikeDepot
  end

  def test_get_homepage_works
    get '/'
    assert last_response.ok?, "getting homepage should work"
  end
end
