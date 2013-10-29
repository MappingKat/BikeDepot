require_relative '../helpers/acceptance_helper'

class ServerTest < Minitest::Test
  include Capybara::DSL

  attr_reader :ser_type_id

  def setup
    ServiceTypes.save(:name => "Wheels")
    @ser_type_id = ServiceTypes.find_all_by_name("Wheels").first.id
  end

  def teardown
    ServiceTypes.dataset.delete
  end

  def test_error_pages_works
    visit '/junk_url_that_does_not_exist'
    assert page.has_content?("Oh no!"), "error page should say Oh no!"
  end

  def test_services_page_works_for_guest
    visit '/services'
    assert page.has_content?("Services"), "service page should say Services!"
  end

  def test_services_page_works_for_admin
    skip # TODO, update after ADMIN is ready
    visit '/services'
    assert page.has_content?("Services!"), "service page should say Services!"
    click_button('edit_services')
    asset page.has_content?('Edit Services')
  end

  def test_service_type_page_works_for_guest
    skip # come back after controllers tests
    visit '/service_types'
    assert page.has_content?("Service Types"), "service_types page should say Service Types!"
    assert page.has_content?("Wheels"), "page should list Wheels type"
  end

  def test_service_type_page_works_for_admin
    skip # UPDATE TEST WHEN ADMIN IS READY TODO
    visit '/service_types'
    assert page.has_content?("Service Types"), "service_types page should say Service Types!"
    click_button('edit_service_types')
    assert page.has_content?("Edit Service Types"), "page should have Edit Service Types"
    assert page.has_content?("Wheels"), "page should list Wheels type"
  end

  def test_service_edit_page_works
    skip
    visit '/services/edit'
    assert page.has_content?("Edit Services"), "should say edit services"
  end

end
