class HotelSearchService
  def self.search_by_city_and_title_contents(city, title_part)
    new(city, title_part).call
  end

  def initialize(city, title_part)
    @city = city
    @title_part = title_part
  end

  def call
    hotels = Hotel.all

    if @city.present?
      hotels = hotels.joins(:city_and_town).where(cities_and_towns: { name: @city })
    end

    if @title_part.present?
      hotels = hotels.where('display_name LIKE ?', "%#{@title_part}%")
    end

    hotels.includes(:city_and_town).select(:id, :city_and_town_id, :display_name).map do |hotel|
      {
        id: hotel.id,
        city: { name: hotel.city_and_town.name },
        display_name: hotel.display_name
      }
    end
  end
end
