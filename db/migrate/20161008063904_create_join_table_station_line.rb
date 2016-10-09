class CreateJoinTableStationLine < ActiveRecord::Migration
  def change
    create_join_table :Stations, :Lines do |t|
      # t.index [:station_id, :line_id]
      # t.index [:line_id, :station_id]
    end
  end
end
