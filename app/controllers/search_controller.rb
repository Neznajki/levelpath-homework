class SearchController < ApplicationController

  def index
    WarmupService.call

    search_result = Hotel.all

    if params[:city].present?
      search_result = search_result.where(city: params[:city])
    end

    if params[:q].present?
      search_result = search_result.where('display_name LIKE ?', "%#{params[:q]}%")
    end

    with_city = search_result.select(:id, :city, :display_name).map do |hotel|
      {
        id: hotel.id,
        city: { name: hotel.city },
        display_name: hotel.display_name
      }
    end

    render json: with_city
  end

end
