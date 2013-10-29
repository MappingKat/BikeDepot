unless ENV['RACK_ENV'] == 'test'
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/dev.db")
else
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/test.db")
end
