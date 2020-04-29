class ChangeAdventureDistanceToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :adventures, :distance, :float
  end
end
