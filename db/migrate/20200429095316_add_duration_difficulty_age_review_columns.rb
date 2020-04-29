class AddDurationDifficultyAgeReviewColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :difficulty, :integer
    add_column :reviews, :duration, :integer
    add_column :reviews, :youngest_age, :integer
  end
end
