class RemoveAvgRating < ActiveRecord::Migration[6.0]
  def change
    remove_column :adventure, :avg_rating
  end
end
