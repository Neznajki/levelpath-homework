class CreateCitiesAndTowns < ActiveRecord::Migration[7.1]
  def change
    create_table :cities_and_towns do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :cities_and_towns, :name, unique: true
  end
end
