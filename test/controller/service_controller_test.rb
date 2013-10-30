ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require './lib/server'

class ServiceControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    BikeDepot
  end

  def test_services_page_works
    Services.save(Service.new(:name => "Rotation"))
    get '/services'
    assert last_response.ok?, "getting '/services' should work"
    assert last_response.include?("Rotation"), "should include Rotation"
    Services.dataset.delete
  end



end
