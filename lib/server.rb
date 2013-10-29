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
    erb :services, locals: {services: Services.all}
  end

  get '/services/edit' do 
    erb :edit_services
  end

  get '/' do

  end

  get '/service_types' do
    erb :service_types, locals: {service_types: ServiceTypes.all}
  end

  get '/service_types/:id/edit' do |id|
    erb :edit_service_types, locals: {service_type: ServiceTypes.find_by_id(id)}
  end

  put '/service_types/:id/edit' do |id|
    ServiceTypes.update(id,params[service_type])
    redirect '/'
  end

end
