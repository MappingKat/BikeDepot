ENV['RACK_ENV'] = 'test'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'digest/md5'

class User
  attr_reader :id, :created_at
  attr_accessor :username, :password, :email

  def initialize(attributes={})
    attributes = default_user.merge(attributes)
    @id          = attributes["id"]
    @username    = attributes["username"]
    @password    = attributes["password"]
    @email       = attributes["email"]
  end

  def to_h
    { "id" => id,
      "username" => username,
      "password" => password,
      "email" => email,
      "created_at" => created_at,
    }
  end

  def default_user
    { "id"         => 100,
      "username"   => "admin",
      "password"   => Digest::MD5.hexdigest("password"),
      "email"      => "email@thebikedepot.com",
      "created_at" => Time.now.to_s
    }
  end
end

  # def load_database
  #   load_services
  # end

  # def load_services
  #   Service.filename = "db/user/#{id}_services"
  # end
