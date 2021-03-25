ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'dotenv/load'
Bundler.require(:default, ENV['SINATRA_ENV'])

set :database, {:adapter =>'sqlite3', :database=>'wiki.db'}

require './app/controllers/application_controller'
require_all 'app'
