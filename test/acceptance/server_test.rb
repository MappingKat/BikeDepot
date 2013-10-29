require_relative '../helpers/acceptance_helper'

class ServerTest < Minitest::Test
  include Capybara::DSL

  def test_it_exists
    assert BikeDepot
  end

  def test_error_pages_works
    visit '/junk_url_that_does_not_exist'
    assert page.has_content?("Oh no!"), "error page should say Oh no!"
  end

  def test_services_page_works
    visit '/services'
    assert page.has_content?("Services!"), "service page should say Services!"
    click_button('edit_services')
    asset page.has_content?('Edit Services')
  end

  def test_service_type_page_works
    visit '/service_types'
    assert page.has_content?("Service Types!"), "service_types page should say Service Types!"
    click_button('edit_service_types')
    assert page.has_content?("Edit Service Types")
  end

  def test_service_type_edit_page_works
    visit '/service_types/edit'
    assert page.has_content?("Edit Service Types"), "should say edit service types"
  end

  def test_service_edit_page_works
    visit '/services/edit'
    assert page.has_content?("Edit Services"), "should say edit services"
  end

end
