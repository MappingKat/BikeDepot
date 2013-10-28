gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require './lib/server'

class ServerTest < Minitest::Test  
  include Rack::Test::Methods

  def test_it_exists
    assert BikeDepot
  end


end
