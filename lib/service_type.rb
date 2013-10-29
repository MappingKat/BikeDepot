require_relative './db_helper'

class ServiceType
   extend Db_helper

  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def to_h
    {
    :name => name
    }
  end

  def save
    # needs to insert into table
    ServiceType.dataset.insert(self.to_h)
  end

  def self.all
    dataset.select
  end

  def self.dataset
    database.from(:service_types)
  end

  def self.database
    Db_helper.database
  end

end
