require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'service_types'
require_relative 'services'

class BikeDepot < Sinatra::Base
  set :method_override, true
  configure :development do
    register Sinatra::Reloader
  end

  set :root, 'lib'

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

  get '/' do
    erb :index
  end

  get '/services' do
    erb :services, locals: {services: Services.all, service_types: ServiceTypes.all}
  end

  post '/services' do
    Services.save(Service.new(params[:service]))
    redirect '/services'
  end

  get '/services/:id/edit' do |id|
    protected!
    erb :edit_services, locals: {service: Services.find_all_by_id(id).first, service_types: ServiceTypes.all}
  end

  put '/services/:id/update' do |id|
    Services.update(id,params[:service])
    redirect "/services"
  end

  post '/service_types' do 
    ServiceTypes.save(ServiceType.new(params[:service_type]))
    redirect '/service_types'
  end

  get '/protected' do
    protected!
    redirect '/services'
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

  get '/about' do 
    erb :about 
    #about/mission-vision-and-values
    #about/history
    #about/staff-board
    #about/contact
    #about/privacy-policy
  end

  get '/contact' do
    erb :contact
  end

  get '/programs' do 
    erb :programs
    #programs/earn-a-bike
    #programs/fix-your-bike
    #programs/classes
    #programs/bike-camp
    #programs/bike-rodeo
  end

  get '/bike-shop' do 
    erb :bike_shop
    #bike-shop/retail
    #bike-shop/service
    #bike-shop/stracycle
  end

  get '/support' do 
    erb :support
    #support/volunteer
    #support/donate-bikes
    #support/organizing-a-bike-collection-drive
    #support/memberships
    #support/wish-list
  end

  get '/events' do 
    erb :events
    #events/calendar
    #events/park-hill-family-bike-ride
  end

  get '/links' do 
    erb :links
    #links/partners
    #links/friends
  end
end
