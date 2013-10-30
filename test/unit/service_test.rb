ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/services'

class ServiceTest < Minitest::Test

  def setup
    service_params = {:service_type_id => 1,
                      :name => "wheels",
                      :description => "replace wheel",
                      :price => 25,
                      :price_details => "per wheel"}
    service = Service.new(service_params)
    Services.save(service)
  end

  def teardown
    Services.dataset.delete
  end

  def test_it_creates_a_service
    assert_equal 1, Services.all.count
  end

  def test_it_reads_a_service
    service = Services.find_all_by_name("wheels")
    assert_equal "wheels", service.first.name
    assert_equal "replace wheel", service.first.description
    assert_equal 25, service.first.price
    assert_equal "per wheel", service.first.price_details
  end

  def test_it_deletes_a_service
    #service = Services.first.destroy
    # binding.pry
    Services.dataset.where(:name => "wheels").delete
    # binding.pry
    assert_equal 0, Services.all.count
  end

  def test_it_updates_a_service
    service = Services.find_all_by_name("wheels")
    old_id = service.first.id
    assert_equal "wheels", service.first.name
    Services.update(old_id, :name => "dingle_donglers")
    updated_service = Services.find_all_by_id(old_id)
    assert_equal "dingle_donglers", updated_service.first.name
  end

end

