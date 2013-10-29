require_relative './db_helper'

# table schema - need to write migrations and then migrate
if false
  property :id, Serial
  property :name, String
end

class ServiceType
   extend Db_helper

   def initialize(attributes)
     @id = attributes[:id]
     @name = attributes[:name]
   end

  def save
    # needs to insert into table
  end

  def self.all
    dataset.select
  end

  def self.dataset
    database.from(:service_types)
  end

  def self.first
    dataset.first
  end

  def self.database
    Db_helper.database
  end

end
