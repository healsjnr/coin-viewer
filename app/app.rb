require 'sinatra'
require 'haml'
require 'json'
require 'faraday'
require 'csv'

class App < Sinatra::Application

  COIN_PATH = File.join('app/public', '/data/dobunni.csv')
  puts "Coin path: #{COIN_PATH}"

  def load_coin_data(coin_path)
     coin_file = File.open(coin_path, "r:ISO-8859-1")
     header_raw, *data = CSV.parse(coin_file)
     header = header_raw.map { |h| h.gsub(' ','').downcase.to_sym }
     data.map { |d| header.zip(d).to_h }
  end

  configure do
     coin_file = File.open(COIN_PATH, "r:ISO-8859-1")
     header_raw, *data = CSV.parse(coin_file)
     header = header_raw.map { |h| h.gsub(' ','').downcase.to_sym }
     @@coin_data = data.map { |d| header.zip(d).to_h }
     puts "Loaded #{@@coin_data.length} coins"
  end

  get '/' do
    haml :main, { :layout => :layout } 
  end

  get '/coins/:coins_db' do
    @@coin_data.to_json
  end

end
