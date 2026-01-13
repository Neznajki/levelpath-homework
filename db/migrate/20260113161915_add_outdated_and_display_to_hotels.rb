class AddOutdatedAndDisplayToHotels < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :outdated, :boolean, default: false, null: false
    add_column :hotels, :display, :boolean, default: true, null: false
    add_index  :hotels, :display
  end
end
