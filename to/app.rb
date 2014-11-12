# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'json/ext'
require 'mongoid'
require 'date'
require 'net/http'
require './config/config.rb'
Dir.glob("./models/*.rb").each { |f| require f }

get '/' do
  message = 'Погода на сегодня с локалки'
  message2 = 'Погода на сегодня с сайта'
  today = WeatherOpen.where(date: { :$gte => DateTime.now.midnight, :$lt => DateTime.now.midnight + 1.day })
  erb :index, locals: { message: message, message2: message2, todays_weather: today }
end