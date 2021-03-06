require_relative '../helpers/acceptance_helper'

class ServiceTypesAcceptanceTest < Minitest::Test
  include Capybara::DSL
  include Rack::Test::Methods

  def app
    BikeDepot
  end

  attr_reader :ser_type_id

  def setup
    ServiceTypes.save(:name => "Wheels")
    @ser_type_id = ServiceTypes.find_all_by_name("Wheels").first.id
  end

  def teardown
    ServiceTypes.dataset.delete
  end

  def test_it_creates_a_new_service_type
    visit '/service_types'
    fill_in('service_type[name]', :with => "handle bars")
    click_button('Submit')
    assert page.has_content?('handle bars'), "page should now display handle bars"
  end

  def test_service_type_edit_page_works_from_other_file
    visit '/service_types/' + ser_type_id.to_s + '/edit'
    assert page.has_content?("Edit Service Types"), "should say edit service types"
    assert page.has_content?("Wheels"), "page should have Wheels"
    fill_in('service_type[name]', :with => "engine")
    click_button('submit')
    assert page.has_content?("engine")
  end
end
