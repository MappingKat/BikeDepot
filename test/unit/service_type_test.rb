ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/service_type'

class ServiceTypeTest < Minitest::Test

  def setup
    service_type_params = {:name => "wheels" }
    service_type = ServiceType.new(service_type_params)
    service_type.save
  end

  def teardown
    #ServiceType.all.destroy!
    ServiceType.database.from(:service_types)
  end

  def test_it_creates_service_type
    assert_equal 1, ServiceType.all.count
  end

  def test_it_read_service_type
    service_type = ServiceType.all.first
    assert_equal "wheels", service_type.name
  end

  def test_it_deletes_a_service_type
    service_type = ServiceType.first.destroy
    assert_equal 0, ServiceType.all.count
  end

  def test_it_updates_a_service_type
    service_type = ServiceType.all.first
    assert_equal "wheels", service_type.name
    service_type.update(:name => "tube installs")
    assert_equal "tube installs", service_type.name
  end

  def test_it_does_not_update_id  #TEST NOT WORKING
    service = ServiceType.all.first
    current_id = service.id
    service.update(:id => 80)
    assert_equal current_id, service.id
  end
end

