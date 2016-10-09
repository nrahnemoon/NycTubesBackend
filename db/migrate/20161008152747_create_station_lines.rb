class CreateStationLines < ActiveRecord::Migration
  def change
    create_table :station_lines do |t|
      t.integer :station_id
      t.integer :line_id

      t.timestamps null: false
    end
  end
end
