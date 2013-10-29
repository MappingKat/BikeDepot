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

  get '/services' do
    erb :services
  end

  get '/services/edit' do 
    erb :edit_services
  end

  get '/' do

  end

  get '/service_types' do 
    erb :service_types
  end

  get '/service_types/edit' do 
    erb :edit_service_types
  end

end
