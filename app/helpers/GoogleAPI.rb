require 'rest-client'
require 'pry'

module GoogleAPI
  KEY = "AIzaSyAa_1I2oAv-cNMvVnW0EeAW6WaUeBniIhE"

  def self.location_url(place)
    "https://maps.googleapis.com/maps/api/geocode/json?address=#{place}&key=#{KEY}"
  end

  def self.duration_url(stops)
    destinations = []
    index = 0
    while index<stops.count-1 do
      destinations.push("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{stops[index].lat},#{stops[index].lng}&destinations=#{stops[index+1].lat}%2C#{stops[index+1].lng}&key=#{KEY}")
      index += 1
    end
    destinations
  end

  def self.getDurations(stops)
    urls = self.duration_url(stops)
    json = urls.map{ |url| JSON.parse(RestClient.get(url)) }
    durations = json.map{|j| j['rows'][0]['elements'][0]['duration']['text']}
    # durations
    index = 1
    while index < stops.count do
      stops[index].update(duration: durations[index-1])
      index += 1
    end
    stops
  end



  def self.coordinates(place)
    url = self.location_url(place)
    response = RestClient.get(url)
    JSON.parse(response)['results'][0]['geometry']['location']
  end




end
