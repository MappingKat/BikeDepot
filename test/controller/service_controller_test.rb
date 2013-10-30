ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require './lib/server'

class ServiceControllerTest < Minitest::Test
  include Rack::Test::Methods

  attr_reader :type_id

  def app
    BikeDepot
  end

  def setup
    ServiceTypes.save(ServiceType.new(:name => "Wheels"))
    @type_id = ServiceTypes.find_all_by_name("Wheels").first.id
  end

  def test_services_page_works
    Services.save(Service.new(:name => "Rotation",
                              :service_type_id => type_id))
    get '/services'
    assert last_response.ok?, "getting '/services' should work"
    assert last_response.body.include?("Rotation"), "should include Rotation"
    Services.dataset.delete
  end

  def test_it_posts_a_service
    post '/services', :service => {:name => "fix wheel", :service_type_id => type_id} #need to add service_type_id
    follow_redirect!
    assert last_response.ok?, "should work with new service"
    assert last_response.body.include?("fix wheel"), "should include fix wheel"
  end

end
