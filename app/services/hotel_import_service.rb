require 'uri'
require 'net/http'

class HotelImportService
  def self.do_import(cities_and_towns)
    new(cities_and_towns).call
  end

  def initialize(cities_and_towns)
    @cities_and_towns = cities_and_towns
  end

  def call
    Hotel.delete_all # would remove if YARGNI wouldn't be part of requirements (better to mark as deleted and unmark deleted if it is imported again. to keep trace) delete_all is more optimal and we have no callback so it is better option.

    @cities_and_towns.each do |city_record|
      uri = URI("http://nominatim:8080/search?q=Hotels%20in%20#{city_record.name}&format=json")
      res = Net::HTTP.get_response(uri)

      results = res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : []

      results.each do |result|
        Hotel.create(city_and_town: city_record, display_name: result["display_name"])
      end
    end
  end
end
