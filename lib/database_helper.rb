require 'sequel'
module Database_helper

  def self.database
    unless ENV['RACK_ENV'] == 'test'
      @db ||= production_db_connection || Sequel.sqlite('database.sqlite3')
      run_migrations
      return @db
    else
      @db ||= Sequel.sqlite('test_database.sqlite3')
      run_migrations
      return @db
    end
  end

  def self.production_db_connection
    if ENV['DATABASE_URL']
      Sequel.connect(ENV['DATABASE_URL'])
    else
      false
    end
  end

  def self.run_migrations_prod
    unless @db.table_exists?(:service_types)
      @db.run "CREATE TABLE service_types(
        id SERIAL PRIMARY KEY,
        name TEXT
      );"
    end

    unless @db.table_exists?(:services)
      @db.run "CREATE TABLE services(
       id SERIAL PRIMARY KEY,
       service_type_id INT,
       name TEXT,
       description TEXT,
       price INT,
       price_details TEXT
      );"
    end
  end

  def self.run_migrations
    if ENV['DATABASE_URL']
      run_migrations_prod
    else
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

end
