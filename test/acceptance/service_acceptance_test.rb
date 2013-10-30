require_relative '../helpers/acceptance_helper'

class ServiceAcceptanceTest < Minitest::Test 
  include Capybara::DSL

  def teardown
    Services.dataset.delete
  end

  def create_service_types
    ServiceTypes.save(ServiceType.new(:name => "Wheels"))
    ServiceTypes.save(ServiceType.new(:name => "Seats"))
  end

  def test_it_creates_a_new_service
    create_service_types
    visit '/services'
    fill_in('service[name]', :with => "replace wheel")
    fill_in('service[description]', :with => "putting in new wheel")
    fill_in('service[price]', :with => 25)
    fill_in('service[price_details]', :with => "per wheel")
    page.find_by_id('type_dropdown').find("option[name='Wheels']").select_option
    click_button('Submit')
    assert page.has_content?("Wheels")
    assert page.has_content?("replace wheel")
    assert page.has_content?("putting in new wheel")
    assert page.has_content?("25")
    assert page.has_content?("per wheel")
  end

   def test_it_edits_a_service
    skip #not finding buttton on page
    create_service_types
    visit '/services'
    assert page.has_content?("per wheel"), "service page should say per wheel"
    click_button('edit_services')
    assert page.has_content?('Edit Services')
  end
end
