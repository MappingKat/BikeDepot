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

  def self.run_migrations
    unless @db.table_exists?(:service_types)
      @db.run "CREATE TABLE service_types (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                             name VARCHAR(255))"
    end

    unless @db.table_exists?(:services)
      @db.run "CREATE TABLE services (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                      service_type_id INTEGER,
                                      name VARCHAR(255),
                                      description VARCHAR(255),
                                      price INTEGER,
                                      price_details VARCHAR(255))"
    end
  end


end
