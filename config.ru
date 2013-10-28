$:.unshift File.expand_path("./../lib", __FILE__)
require 'server'
require 'bundler'

Bundler.require

run BikeDepot
