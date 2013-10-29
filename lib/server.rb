require 'sinatra/base'
require 'sinatra/reloader'
#config.ru should take care of these

class BikeDepot < Sinatra::Base
  #set :method_override, true
  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

end
