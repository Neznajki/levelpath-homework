class AddUniqueIndexToHotelsCityAndTownAndDisplayName < ActiveRecord::Migration[7.1]
  def change
    add_index :hotels,
              [:city_and_town_id, :display_name],
              unique: true,
              name: 'index_hotels_on_city_and_town_id_and_display_name'
  end
end
