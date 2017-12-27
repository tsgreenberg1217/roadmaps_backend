require 'rest-client'
module GoogleAPI
  KEY = ""

  def self.location_url(place)
    "https://maps.googleapis.com/maps/api/geocode/json?address=#{place}&key=#{KEY}"
  end

  # def self.duration_url(stops)
  #   destinations = []
  #   origin = stops.shift
  #   stops.each{|loc| destinations += "#{loc['lat']}%2C#{loc['lng']}%7C"}
  #   destinations.chomp('%7C')
  #   "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{origin.lat},#{origin.lng}&destinations=#{destinations}&key=#{KEY}"
  # end

  def self.duration_url(stops)
    destinations = []
    index = 0
    while index<stops.count-1 do
      destinations.push("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{stops[index].lat},#{stops[index].lng}&destinations=#{stops[index+1].lat}%2C#{stops[index+1].lng}&key=#{KEY}")
      index += 1
    end
    byebug
    destinations
  end

  def self.getDurations(stops)
    urls = self.duration_url(stops)
    json = urls.map{ |url| JSON.parse(RestClient.get(url)) }
    durations = json.map{|j| j['rows'][0]['elements'][0]['duration']['text']}
    durations
  end



  def self.coordinates(place)
    url = self.location_url(place)
    response = RestClient.get(url)
    JSON.parse(response)['results'][0]['geometry']['location']
  end




end
