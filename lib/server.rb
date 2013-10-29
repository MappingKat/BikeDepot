require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'service_types'
require_relative 'services'
require 'pry'
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
    "hello!" # need a view here
  end

  get '/service_types' do
    erb :service_types, locals: {service_types: ServiceTypes.all}
  end

  get '/service_types/:id/edit' do |id|
    erb :edit_service_types, locals: {service_type: ServiceTypes.find_all_by_id(id).first}
  end

  put '/service_types/:id/edit' do |id|
    ServiceTypes.update(id,params[:service_type])
    redirect '/service_types'
  end

  post '/service_types' do 
    ServiceTypes.save(ServiceType.new(params[:service_type]))
    redirect '/service_types'
  end

end
