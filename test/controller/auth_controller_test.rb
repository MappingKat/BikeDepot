ENV['RACK_ENV'] = 'test'

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require './lib/auth'
require './lib/server'

class BikeDepotAuthTest < Minitest::Test
  include Rack::Test::Methods

  def app
    @app ||= BikeDepot.new
  end

  def test_get_login_page_works
    get '/session/login'
    assert last_response.ok?, "getting login should work"
  end

  def test_get_login_method_returns_the_login_page
    get 'session/login'
    assert last_response.body.include?("Username:")
  end

  def test_the_get_logout_method_redirecs_to_root_menu
    get 'session/logout'
    assert_equal 302, last_reponse.status
  end
end
