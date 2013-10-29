require 'sinatra/base'
require 'sinatra/reloader'
#config.ru should take care of these

class BikeDepot < Sinatra::Base
  #set :method_override, true
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
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
  end
  end

  not_found do
    erb :error
  end

  get '/' do
    "Everybody can see this page"
  end

  get '/protected' do
    protected!
    "Welcome, authenticated client"
  end


  get '/services' do

  end

  get '/' do

  end

  get '/service_types' do 

  end
end
