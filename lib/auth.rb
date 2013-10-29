require 'sinatra/base'
require 'sinatra/flash'
require 'digest/md5'
require './lib/server' #need to check this

module Sinatra
  module Auth
    module Helpers

    def authorized?
      session[:personel]
    end

    def self.registered(app)
        app.helpers Helpers

        app.enable :sessions

        app.get 'session/login' do
          erb :login
        end

      app.post '/session/login' do
        user = User.new
        if user && user.password == login_try
          session[:personel] = params[:username]
          user.load_database
          flash[:notice] = "You are loggin in as #{session[:persona].capitalize}"
          redirect '/'
        else 
          flash[:error] = "The username or password you entered is not correct."
          redirect to('session/login')
        end
      end

      app.get '/session/logout' do
        session[:personel] = nil
        flash[:notice] = "You have now logged out."
        redirect to ('/')
      end
    end

  end
  register Auth
end
