require 'rest-client'
module GoogleAPI
  KEY = ""

  def self.url(place)
    "https://maps.googleapis.com/maps/api/geocode/json?address=#{place}&key=#{KEY}"
  end

  def self.coordinates(place)
    url = self.url(place)
    response = RestClient.get(url)
    JSON.parse(response)['results'][0]['geometry']['location']
  end
end
