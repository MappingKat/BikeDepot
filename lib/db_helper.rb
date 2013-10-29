module Db_helper

  def self.database
    unless ENV['RACK_ENV'] == 'test'
      @db ||= ENV['DATABASE_URL'] || Sequel.sqlite('database.sqlite3')
      return @db
    else
      @db ||= Sequel.sqlite('test_database.sqlite3')
      return @db
    end
    run_migrations
  end

  def self.run_migrations
    unless @db.table_exists?(:service_types)
      @db.run "CREATE TABLE service_types (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                             name VARCHAR(255))"
    end
  end


end
