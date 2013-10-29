ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/user'

class UserTest < Minitest::Test

  def setup
    user_params =    {"id" => 2, 
                      "username" => "admin", 
                      "password" => "heyheyhey",
                      "email" => "joe@email.com"}
  end

  def test_it_exists
    assert User
  end

  def test_it_can_set_up_attrs
    user = User.new({
      'id'           => 1,
      'username'     => 'girl',
      'password'     => 'passwords',
      'email'        => 'katrina@engelsted.co',
      'created_at'   => Time.now
      })
    assert_respond_to user, :id
    assert_respond_to user, :username
    assert_respond_to user, :password
    assert_equal 'katrina@engelsted.co', user.email
  end

  def test_it_can_populate_default_attrs
    user = User.new
    assert_respond_to user, :id
    assert_respond_to user, :username
    assert_equal Digest::MD5.hexdigest('password'), user.password
    assert_respond_to user, :email
    assert_respond_to user, :created_at
  end

  def test_it_can_load_editing_services_db
    skip
    user = User.new
    user.load_editing
    assert_equal "db/user/#{user.id}_editing", Service.filename
  end
end
