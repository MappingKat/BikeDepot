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

end
