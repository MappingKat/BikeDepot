require 'bundler'
Bundler.require 

class BikeDepot < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

end
