require 'sinatra'
require 'mongoid'
require 'json/ext'
require 'rack/cors'
require 'date'

Dir.glob("./{config,models}/*.rb").each { |f| require f }

use Rack::Cors do
  allow do
    origins '*'
    resource '/todays_weather.:format', :headers => :any, :methods => :get
  end
end

get '/' do
  all = Weather.all
  message = 'Погода'
  erb :index, locals: { message: message, all: all }
end

get "/todays_weather.?:format?" do
  today = Weather.where(date: { :$gte => DateTime.now.midnight, :$lt => DateTime.now.midnight + 1.day })
  case format = params['format']
  when 'json'
    content_type :json
    today.to_json
  else
    { error: 'No data' }.to_json
  end
end
