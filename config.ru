$:.unshift File.expand_path("./../lib", __FILE__)
require 'server'
require 'bundler'
require 'data_mapper'
Bundler.require

run BikeDepot
