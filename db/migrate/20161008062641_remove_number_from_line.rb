class RemoveNumberFromLine < ActiveRecord::Migration
  def change
  	remove_column :lines, :number
  end
end
