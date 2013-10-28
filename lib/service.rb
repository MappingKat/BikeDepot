require 'data_mapper'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/dev.db")

class Service
  include DataMapper::Resource

  property :id, Serial
  property :service_type_id, Integer
  property :name, String 
  property :description, Text
  property :price, Integer
  property :price_details, String

end

 
DataMapper.auto_upgrade!  


