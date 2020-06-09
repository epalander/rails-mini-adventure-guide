class MyAdventure < ApplicationRecord
  belongs_to :user
  belongs_to :adventure
  validates :user, uniqueness: { scope: :adventure,
    message: "You already saved this adventure!" }

end
