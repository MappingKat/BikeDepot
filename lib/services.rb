require_relative './db_helper'
require 'service'

class Services
  extend Db_helper

  def self.save(object)
    dataset.insert(object.to_h)
  end

  def self.find_all_by_name(search_term)

  end

  def self.dataset
    database.from(:services)
  end

  def self.all

  end

  def self.database
    Db_helper.database
  end

end
