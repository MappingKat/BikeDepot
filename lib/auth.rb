require 'sinatra/base'
require 'sinatra/reloader'

class App < Sinatra::Base
  set :sessions => true

  register do 
    def auth (type)
      condition do 
        redirect '/login' unless send(is_#{})

      def authorized?
        session[:person]
      end

      def protected!
        halt 401, erb(:unauthorized) unless authorized
        end
      end

      def self.registered(app)
        app.helpers Helpers

        app.enable :sessions

        app.get 'session/login' do
          erb :login
        end
      end
