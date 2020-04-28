class AddAddressToAdventures < ActiveRecord::Migration[6.0]
  def change
    add_column :adventures, :address, :string
  end
end
