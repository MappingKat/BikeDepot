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
    assert page.has_content?("Think this page should be here?"), "error page should say Oh no!"
  end

  def test_services_page_works_for_guest
    visit '/services'
    assert page.has_content?("Services"), "service page should say Services!"
  end

  def test_service_type_page_works_for_guest
    visit '/service_types'
    assert page.has_content?("Service Types"), "service_types page should say Service Types!"
    assert page.has_content?("Wheels"), "page should list Wheels type"
  end

  def test_service_type_page_works_for_admin
    visit '/service_types'
    assert page.has_content?("Service Types"), "service_types page should say Service Types!"
    click_button('Edit')
    assert page.has_content?("Edit Service Types"), "page should have Edit Service Types"
    assert page.has_content?("Wheels"), "page should list Wheels type"
  end

end
