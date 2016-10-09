class CreateStationEdges < ActiveRecord::Migration
  def change
    create_table :station_edges do |t|
      t.decimal :distance
      t.integer :from_station_id
      t.integer :to_station_id

      t.timestamps null: false
    end
  end
end
