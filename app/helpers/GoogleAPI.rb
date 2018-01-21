require 'rest-client'

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
    distances = json.map{|j| j['rows'][0]['elements'][0]['distance']['text']}
    index = 1
    while index < stops.count do
      stops[index].update(duration: durations[index-1])
      stops[index].update(distance: distances[index-1].split(' mi').join('').to_i)
      index += 1
    end
    stops
  end


  def self.validateCoordinates
    url = self.location_url(place)
    response = RestClient.get(url)
    begin
      coordinates = JSON.parse(response)['results'][0]['geometry']['location']
    rescue
      binding.pry
      return 'invalid place'
    end
    coordinates
  extend



  def self.coordinates(place)
    url = self.location_url(place)
    response = RestClient.get(url)
    coordinates = JSON.parse(response)['results'][0]['geometry']['location']

  end




end
