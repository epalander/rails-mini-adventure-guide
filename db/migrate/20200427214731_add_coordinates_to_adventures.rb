class AddCoordinatesToAdventures < ActiveRecord::Migration[6.0]
  def change
    add_column :adventures, :latitude, :float
    add_column :adventures, :longitude, :float
  end
end
