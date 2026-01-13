class AddTimestampDefaultsToHotels < ActiveRecord::Migration[7.1]
  def change
    change_column_default :hotels, :created_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
