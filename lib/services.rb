require_relative './db_helper'
require_relative './service'

class Services
  extend Db_helper

  def self.save(object)
    dataset.insert(object.to_h)
  end

  def self.find_all_by_service_type_id(search_term)
    table_data = dataset.where(:service_type_id => search_term)
    table_data.map{|d| Service.new(d)}
  end

  def self.find_all_by_name(search_term)
    table_data = dataset.where(:name => search_term)
    objects = table_data.map {|d| Service.new(d)}
  end

  def self.find_all_by_id(search_term)
    table_data = dataset.where(:id => search_term)
    objects = table_data.map {|d| Service.new(d)}
  end

  def self.update(id,params)
    dataset.where(:id => id).update(params)
  end

  def self.dataset
    database.from(:services)
  end

  def self.all
    dataset.select.to_a.map {|data| Service.new(data)}
  end

  def self.database
    Db_helper.database
  end

end
