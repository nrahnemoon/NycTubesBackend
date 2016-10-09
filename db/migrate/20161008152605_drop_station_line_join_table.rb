class DropStationLineJoinTable < ActiveRecord::Migration
  def change
  	drop_table :Lines_Stations
  end
end
