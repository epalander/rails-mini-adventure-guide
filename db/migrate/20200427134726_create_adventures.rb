class CreateAdventures < ActiveRecord::Migration[6.0]
  def change
    create_table :adventures do |t|
      t.string :title
      t.text :description
      t.string :category
      t.float :avg_rating
      t.integer :distance
      t.integer :avg_duration
      t.boolean :stroller_friendly
      t.integer :youngest_age
      t.integer :difficulty
      t.boolean :parking
      t.boolean :public_transport
      t.text :directions

      t.timestamps
    end
  end
end
