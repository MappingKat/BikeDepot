ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/service_types'

class ServiceTypeTest < Minitest::Test

  def setup
    service_type_params = {:name => "wheels" }
    service_type = ServiceType.new(service_type_params)
    ServiceTypes.save(service_type)
  end

  def teardown
    #ServiceType.all.destroy!
    ServiceTypes.dataset.delete
  end

  def test_it_creates_service_type
    assert_equal 1, ServiceTypes.all.count
  end

  def test_it_read_service_type
    service_type = ServiceTypes.dataset.all.where(:name => "wheels")
    assert_equal "wheels", service_type.first.name
  end

  def test_it_deletes_a_service_type
    service_type = ServiceTypes.dataset.where(:name => "wheels").delete
    assert_equal 0, ServiceTypes.all.count
  end

  def test_it_updates_a_service_type
    service_type = ServiceTypes.find_by_name("wheels")
    assert_equal "wheels", service_type.name
    service_type.update(:name => "tube installs")
    assert_equal "tube installs", service_type.name
  end

  def test_it_does_not_update_id
    service = ServiceTypes.all.where(:id => 1)
    current_id = service.first.id
    service.update(:id => 80)
    assert_equal current_id, service.id
  end
end

