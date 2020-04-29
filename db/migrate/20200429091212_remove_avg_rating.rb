class RemoveAvgRating < ActiveRecord::Migration[6.0]
  def change
    remove_column :adventures, :avg_rating
  end
end
