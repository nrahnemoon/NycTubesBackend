class AddLineNumber < ActiveRecord::Migration
  def change
  	add_column :stations, :lineNumber, :integer
  	change_column :stations, :line, :string
  	rename_column :stations, :line, :lineName
  end
end
