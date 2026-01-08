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
    HotelImportService.do_import(cities_and_towns)

    import_record.update(import_start: import_start, import_end: Time.current)
  end
end
