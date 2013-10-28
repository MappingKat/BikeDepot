gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/service'

class ServiceTest < Minitest::Test  

  def setup
    service_params = {:service_type_id => 1, 
                      :name => "wheels", 
                      :description => "replace wheel",
                      :price => 25,
                      :price_details => "per wheel"}
    service = Service.new(service_params)
    service.save
  end

  def teardown
    Service.all.destroy!
  end

  def test_it_creates_a_service
    assert_equal 1, Service.all.count
  end

  def test_it_reads_a_service
    service = Service.all.first
    assert_equal "wheels", service.name
  end


end

