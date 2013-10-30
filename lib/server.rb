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

  set :root, 'lib'

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
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
    erb :services, locals: {services: Services.all}
  end

  get '/services/edit' do 
    erb :edit_services
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

  post '/service_types' do 
    ServiceTypes.save(ServiceType.new(params[:service_type]))
    redirect '/service_types'
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

  get '/events' do 
    erb :events
    #events/calendar
    #events/park-hill-family-bike-ride
  end

  get '/links' do 
    erb :links
    #links/business-partners
    #links/friends
    #links/we-love
  end
end
