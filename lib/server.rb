require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'service_types'
require_relative 'services'
require 'pry'
#config.ru should take care of these

class BikeDepot < Sinatra::Base
  set :method_override, true
  configure :development do
    register Sinatra::Reloader
  end

   helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
      # if authorized?
      #   return true
      # else
      #   headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      #   halt 401, "Not authorized\n"
      # end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    end
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

  get '/protected' do
  protected!
  "Welcome, authenticated client"
  end

  get '/service_types' do
    erb :service_types, locals: {service_types: ServiceTypes.all}
  end

  get '/service_types/:id/edit' do |id|
    erb :edit_service_types, locals: {service_type: ServiceTypes.find_all_by_id(id).first}
  end

  put '/service_types/:id/update' do |id|
    # binding.pry
    ServiceTypes.update(id,params[:service_type])
    # binding.pry
    redirect "/service_types"
  end

  post '/service_types' do 
    ServiceTypes.save(ServiceType.new(params[:service_type]))
    redirect '/service_types'
  end

end
