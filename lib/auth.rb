require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

set :username,'Bond'
set :token,'shakenN0tstirr3d'
set :password,'007'

helpers do
  def admin? ; request.cookies[settings.username] == settings.token ; end
  def protected! ; halt [ 401, 'Not Authorized' ] unless admin? ; end
end

get '/' do
  haml :index
end

get('/admin'){ haml :admin }

post '/login' do
  if params['username']==settings.username&&params['password']==settings.password
    response.set_cookie(settings.username,settings.token) 
    redirect '/'
  else
    "Username or Password incorrect"
  end
end

get('/logout'){ response.set_cookie(settings.username, false) ; redirect '/' }

get '/public' do
  'Anyone can see this'
end

get '/private' do
  protected!
  'For Your Eyes Only!'
end

__END__

