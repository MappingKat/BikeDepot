require_relative '../helpers/acceptance_helper'

class ServiceAcceptanceTest < Minitest::Test 
  include Capybara::DSL

  def teardown
    Services.dataset.delete
  end

  def create_service_types
    # makes some service types, like "Wheels" and "Seats"
  end

  def test_it_creates_a_new_service
    visit '/services'
    fill_in('service[name]', :with => "replace wheel")
    fill_in('service[description]', :with => "putting in new wheel")
    fill_in('service[price]', :with => 25)
    fill_in('service[price_details]', :with => "per wheel")
    # select a service type from a dropdown menu, "Wheel"
    click_button('Submit')
    assert page.has_content?("replace wheel")
    assert page.has_content?("putting in new wheel")
    assert page.has_content?("25")
    assert page.has_content?("per wheel")
    #assert the new service is under the right service_type
  end
end
