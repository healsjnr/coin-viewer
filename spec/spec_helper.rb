$:.unshift File.join(File.dirname(__FILE__), '..')
require 'bundler/setup'
require 'sinatra'
ENV['RACK_ENV'] = 'test'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment
require 'rspec'
require 'machinist'
require 'app/app.rb'

Capybara.app = App 
set :root, File.expand_path('app')
set :environment, :test
set :run, false
set :raise_errors, true
set :dump_errors, false 
set :show_exceptions, false
set :logging, false

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
end
