require 'data_mapper'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/dev.db")

class ServiceType
  include DataMapper::Resource

  property :id, Serial
  property :name, String

end

DataMapper.auto_upgrade!  
