class AddCityReferenceToHotels < ActiveRecord::Migration[7.1]
  def change
    add_reference :hotels, :city_and_town, null: false, foreign_key: { to_table: :cities_and_towns }
    change_column_null :hotels, :display_name, false

    # We will remove the old city column in a separate step or here if we don't care about data migration for now
    # Given it's a warmup service that recreates data, we can just drop it.
    remove_column :hotels, :city, :string
  end
end
