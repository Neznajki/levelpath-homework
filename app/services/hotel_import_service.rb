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
    hotels_data = fetch_hotels_in_parallel

    Hotel.update_all(outdated: true)
    Hotel.upsert_all(hotels_data, unique_by: :index_hotels_on_city_and_town_id_and_display_name) if hotels_data.any?
    Hotel.where(outdated: true).update_all(display: false)#could be deleted but I decided to trace history
  end

  private

  def fetch_hotels_in_parallel
    hotels_data = []
    mutex = Mutex.new

    threads = @cities_and_towns.map do |city_record|
      Thread.new do
        updateCityHotels(city_record, hotels_data, mutex)
      end
    end

    threads.each(&:join)
    hotels_data
  end

  def updateCityHotels(city_record, hotels_data, mutex)
    uri = URI("http://nominatim:8080/search?q=Hotels%20in%20#{city_record.name}&format=json")
    res = Net::HTTP.get_response(uri)

    results = res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : []

    city_hotels = results.map do |result|
      {
        city_and_town_id: city_record.id,
        display_name: result["display_name"],
        updated_at: Time.current, #it may go out of sync in case DB time zone is different from server. if so create custom QUERY or complex logic
        outdated: false,
        display: true
      }
    end

    mutex.synchronize do
      hotels_data.concat(city_hotels)
    end
  end
end
