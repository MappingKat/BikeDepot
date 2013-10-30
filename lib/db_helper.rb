module Db_helper

  def self.database
    unless ENV['RACK_ENV'] == 'test'
      @db ||= ENV['DATABASE_URL'] || Sequel.sqlite('database.sqlite3')
      run_migrations
      return @db
    else
      @db ||= Sequel.sqlite('test_database.sqlite3')
      run_migrations
      return @db
    end
  end

  def self.database_connection
    if ENV['RACK_ENV'] == 'production'
      @db ||= Sequel.connect(ENV['DATABASE_URL'])
      return @db
    else
      return @db
    end
  end

  def self.run_migrations
    unless database_connection.table_exists?(:service_types)
      database_connection.run "CREATE TABLE service_types (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                             name VARCHAR(255))"
    end

    unless database_connection.table_exists?(:services)
      database_connection.run "CREATE TABLE services (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                      service_type_id INTEGER,
                                      name VARCHAR(255),
                                      description VARCHAR(255),
                                      price INTEGER,
                                      price_details VARCHAR(255))"
    end
  end


end
