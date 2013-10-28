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

  def test_get_services_page_works
    get '/services'
    assert last_response.ok?, "getting '/services' should work"
  end
end
