require_relative './db_helper'
require 'service_type'

class ServiceTypes
  extend Db_helper

  def self.save(object)
    dataset.insert(object.to_h)
  end

  def self.all
    dataset.select.to_a.map {|data| ServiceType.new(data)}
  end

  def self.update

  end

  def self.find_by_name(search_term)
    obj = all.where(:name => search_term)
    ServiceType.new(obj.to_h)
  end

  def self.dataset
    database.from(:service_types)
  end

  def self.database
    Db_helper.database
  end

end
