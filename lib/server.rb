require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'service_types'
require_relative 'services'
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
    end

    def authorized?
      return true if ENV['RACK_ENV'] == 'test'
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    end
  end

  not_found do
    erb :error
  end

  get '/services' do
    erb :services, locals: {services: Services.all, service_types: ServiceTypes.all}
  end

  post '/services' do
    Services.save(Service.new(params[:service]))
    redirect '/services'
  end

  post '/service_types' do 
    ServiceTypes.save(ServiceType.new(params[:service_type]))
    redirect '/service_types'
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
    protected!
    erb :edit_service_types, locals: {service_type: ServiceTypes.find_all_by_id(id).first}
  end

  put '/service_types/:id/update' do |id|
    ServiceTypes.update(id,params[:service_type])
    redirect "/service_types"
  end

  delete '/service_types/:id/delete' do |id|
    protected!
    ServiceTypes.delete(id.to_i)
    redirect '/service_types'
  end

end
