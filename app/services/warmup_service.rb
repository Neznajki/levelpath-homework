require 'uri'
require 'net/http'

class WarmupService
  def self.call
    cities_and_towns = %w[
      Daugavpils
      Jelgava
      Jurmala
      Liepaja
      Rezekne
      Riga
      Ventspils
      Sigulda
      Cesis
      Kuldiga
    ]

    Hotel.delete_all

    cities_and_towns.each do |city|
      uri = URI("http://nominatim:8080/search?q=Hotels%20in%20#{city}&format=json")
      res = Net::HTTP.get_response(uri)

      results = res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : []

      results.each do |result|
        Hotel.create(city: city, display_name: result["display_name"])
      end
    end
  end
end
