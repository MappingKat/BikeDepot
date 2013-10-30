ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/services'
require './lib/service_types'

class ServiceTypeServicesAssoicationsTest < Minitest::Test

  def setup
    create_service_type
    create_services_with_type
  end

  def create_service_type
    service_type_params = {:name => "wheels"}
    service_type = ServiceType.new(service_type_params)
    ServiceTypes.save(service_type)
  end

  def create_services_with_type
    service_type_id = ServiceTypes.find_all_by_name("wheels").first.id
    first_service_params = {:name => "true front wheel",
                            :service_type_id => service_type_id}
    Services.save(Service.new(first_service_params))
    second_service_params = {:name => "install spokes",
                             :service_type_id => service_type_id}
    Services.save(Service.new(second_service_params))
    other_service_params = {:name => "break it",
                            :service_type_id => 9999}
    Services.save(Service.new(other_service_params))
  end

  def teardown
    ServiceTypes.dataset.delete
    Services.dataset.delete
  end

  def test_service_type_has_associated_services
    service_type = ServiceTypes.find_all_by_name("wheels").first
    associated_services = service_type.services
    assert_equal ["true front wheel","install spokes"],
                 associated_services.map(&:name)
  end

end
