class SearchController < ApplicationController

  def index
    WarmupService.call

    q = params[:q] || ''

    search_result = Hotel.all.select{ |i| i.display_name.include? q }

    with_city = search_result.map do |hotel|
      {
        **hotel.attributes,
        city: { name: hotel['city'] },
      }
    end

    render json: with_city
  end

end
