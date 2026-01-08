class SearchController < ApplicationController

  def index
    WarmupService.call
    render json: HotelSearchService.search_by_city_and_title_contents(params[:city], params[:q])
  end

end
