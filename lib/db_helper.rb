module Db_helper

  def self.database
    unless ENV['RACK_ENV'] == 'test'
      @database ||= ENV['DATABASE_URL'] || Sequel.sqlite('database.sqlite3')
    else
      @database ||= Sequel.sqlite('test_database.sqlite3')
    end
  end

end
