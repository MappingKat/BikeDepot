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

  def test_service_type_page_works
    get '/service_types'
    assert last_response.ok?, "getting service_type should work"
  end

end
