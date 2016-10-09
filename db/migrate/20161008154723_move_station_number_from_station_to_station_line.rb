class MoveStationNumberFromStationToStationLine < ActiveRecord::Migration
  def change
  	remove_column :stations, :stationNumber
  	add_column :station_lines, :station_number, :integer
  end
end
