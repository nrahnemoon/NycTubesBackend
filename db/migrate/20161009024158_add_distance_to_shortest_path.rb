class AddDistanceToShortestPath < ActiveRecord::Migration
  def change
  	add_column :shortest_paths, :distance, :decimal
  end
end
