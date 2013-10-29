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
    assert_equal "replace wheel", service.description
    assert_equal 25, service.price
    assert_equal "per wheel", service.price_details
  end

  def test_it_deletes_a_service
    service = Service.first.destroy 
    assert_equal 0, Service.all.count
  end

  def test_it_updates_a_service
    service = Service.all.first
    assert_equal "wheels", service.name
    service.update(:name => "dingle_donglers")
    assert_equal "dingle_donglers", service.name
  end

  def  test_it_does_not_update_id
    current_id = Service.all.first.id
    Service.all.first.update(:id => 80)
    assert_equal current_id, Service.all.first.id
  end

end

