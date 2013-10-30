ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require './lib/server'

class ServiceTypeControllerTest < Minitest::Test
  include Rack::Test::Methods

    attr_reader :ser_type_id

  def app
    BikeDepot
  end

  def teardown
    ServiceTypes.dataset.delete
  end

  def setup
    ServiceTypes.save(:name => "Wheels")
    @ser_type_id = ServiceTypes.find_all_by_name("Wheels").first.id
  end

  def test_service_type_page_works
    get '/service_types'
    assert last_response.ok?, "getting service_type should work"
    assert last_response.body.include?("Wheels"), "should say wheels on service type page"
  end

  def test_service_type_edit_page_works
    get '/service_types/' + ser_type_id.to_s + '/edit'
    assert last_response.ok?
    assert last_response.body.include?("Edit Service Types")
  end

  def test_it_updates_via_put
    put '/service_types/' + ser_type_id.to_s + '/update', :service_type => {:name => "new name"}
    assert last_response.redirect?, "route was not redirected"
    follow_redirect!
    assert last_response.ok?, "response should be okay"
    assert last_response.body.include?("new name"), "should include new name"
  end

  def test_it_posts_a_new_service_type
    post '/service_types', :service_type => {:name => "oil change"}
    follow_redirect!
    assert last_response.ok?, "should work with new service type"
  end
end

