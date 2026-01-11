class DropDataImports < ActiveRecord::Migration[7.1]
  def change
    drop_table :data_imports do |t|
      t.datetime :import_start
      t.datetime :import_end
      t.timestamps
    end
  end
end
