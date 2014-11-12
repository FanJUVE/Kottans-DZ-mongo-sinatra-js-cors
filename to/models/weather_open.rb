class WeatherOpen
  include Mongoid::Document

  field :date,  type: DateTime
  field :city,  type: String
  field :temp,  type: String
  field :sky,  type: String

  def self.openweather
    url = 'http://api.openweathermap.org/data/2.5/group?id=703448,702550,709930&APPID=3b62a8149adccded6e40880db95e9449'
    res = Net::HTTP.get_response(URI.parse(url))
    data = res.body
    resp = JSON.parse(data)

    batch = Array.new
    date = DateTime.now.in_time_zone.to_date
    resp['list'].each do |city|
      weather = Hash.new
      weather[:date] = date
      weather[:city] = city['name']
      weather[:temp] = "#{(city['main']['temp_min'] - 273).floor} .. #{(city['main']['temp_max'] - 273).ceil}"
      weather[:sky] = city['weather'][0]['description']
      batch << weather
    end
    WeatherOpen.collection.insert(batch);
  end

end