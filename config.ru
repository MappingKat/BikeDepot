$:.unshift File.expand_path("./../lib", __FILE__)
require 'server'
require 'bundler'
require 'sinatra'
require 'sinatra/reloader'


Bundler.require

run BikeDepot
