require_relative '../helpers/acceptance_helper'

class BikeDepotTest < Minitest::Test
  include Rack::Test::Methods

   def app
    BikeDepot
  end

  def test_without_authentication
    get '/protected'
    assert_equal 401, last_response.status
  end

  def test_with_bad_credentials
    authorize 'bad', 'boy'
    get '/protected'
    assert_equal 401, last_response.status
  end

  def test_with_proper_credentials
    authorize 'admin', 'admin'
    get '/protected'
    assert_equal 200, last_response.status
    assert_equal "Welcome, authenticated client", last_response.body
  end
end

