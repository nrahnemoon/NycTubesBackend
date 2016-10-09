class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.integer :line
      t.integer :stationNumber
      t.decimal :lattitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end
