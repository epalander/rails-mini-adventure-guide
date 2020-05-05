class AddUserToAdventure < ActiveRecord::Migration[6.0]
  def change
    add_reference :adventures, :user, null: false, foreign_key: true
  end
end
