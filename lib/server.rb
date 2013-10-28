require 'sinatra'
require 'sinatra/reloader'
#config.ru should take care of these 

class BikeDepot < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  

end
