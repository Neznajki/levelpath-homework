require 'uri'
require 'net/http'

class WarmupService
  def self.call
    import_record = DataImport.first

    if import_record
      if import_record.import_end && import_record.import_end > 10.minutes.ago
        return
      end
    else
      import_record = DataImport.new
    end

    import_start = Time.current

    cities_and_towns = CityAndTown.all

    Hotel.delete_all # would remove if YARGNI wouldn't be part of requirements (better to mark as deleted and unmark deleted if it is imported again. to keep trace) delete_all is more optimal and we have no callback so it is better option.

    cities_and_towns.each do |city_record|
      uri = URI("http://nominatim:8080/search?q=Hotels%20in%20#{city_record.name}&format=json")
      res = Net::HTTP.get_response(uri)

      results = res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : []

      results.each do |result|
        Hotel.create(city_and_town: city_record, display_name: result["display_name"])
      end
    end

    import_record.update(import_start: import_start, import_end: Time.current)
  end
end
