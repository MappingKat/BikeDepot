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

  def self.update(id,params)
    dataset.where(:id => id).update(params)
  end

  def self.find_all_by_name(search_term)
    table_data = dataset.where(:name => search_term)
    objects = table_data.map {|d| ServiceType.new(d)}
  end

  def self.find_all_by_id(search_term)
    table_data = dataset.where(:id => search_term)
    objects = table_data.map {|d| ServiceType.new(d)}
  end

  def self.dataset
    database.from(:service_types)
  end

  def self.database
    Db_helper.database
  end

  def self.delete(id)
    dataset.where(:id => id.to_i).delete
  end
end
