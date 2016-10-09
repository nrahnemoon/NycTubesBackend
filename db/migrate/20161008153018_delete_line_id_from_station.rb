class DeleteLineIdFromStation < ActiveRecord::Migration
  def change
  	remove_column :stations, :line_id
  end
end
