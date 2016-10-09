class CreateShortestPaths < ActiveRecord::Migration
  def change
    create_table :shortest_paths do |t|
      t.string :path
      t.integer :from_station_id
      t.integer :to_station_id

      t.timestamps null: false
    end
  end
end
