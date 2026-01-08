class CreateDataImports < ActiveRecord::Migration[7.1]
  def change
    create_table :data_imports do |t|
      t.datetime :import_start
      t.datetime :import_end

      t.timestamps
    end
  end
end
