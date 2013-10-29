require 'data_mapper'
require_relative './db_helper'

class ServiceType
  include DataMapper::Resource

  property :id, Serial
  property :name, String

end

DataMapper.auto_upgrade!
