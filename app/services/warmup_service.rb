class WarmupService
  def self.call
    cities_and_towns = CityAndTown.all
    HotelImportService.do_import(cities_and_towns)
  end
end
