require 'bundler/setup'
require 'i18n'
require 'jsonapi-serializers'
require 'draper'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/namespace'
require 'warden'

# Default environment configuration for the application.
Bundler.require :default, ENV["SINATRA_ENV"].to_sym || 'development'

module SinatraApi
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)
    require File.join(root, '/config/initializers/autoloader.rb')
  end
end