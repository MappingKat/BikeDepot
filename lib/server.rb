require 'sinatra/base'
require 'sinatra/reloader'

#config.ru should take care of these

class BikeDepot < Sinatra::Base
  #set :method_override, true
  configure :development do
    register Sinatra::Reloader
  end

  set :root, 'lib'
  # set :public_folder, 'public'

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

  get '/protected' do
    protected!
    "Welcome, authenticated client"
  end

  get '/services' do
    erb :services
  end

  get '/services/edit' do 
    erb :edit_services
  end

  get '/service_types' do 
    erb :service_types
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
  end

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
