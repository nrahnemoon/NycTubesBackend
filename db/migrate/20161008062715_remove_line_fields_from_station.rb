class RemoveLineFieldsFromStation < ActiveRecord::Migration
  def change
  	remove_column :stations, :lineName
  	remove_column :stations, :lineNumber
  end
end
