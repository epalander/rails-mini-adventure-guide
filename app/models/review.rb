class Review < ApplicationRecord
  belongs_to :adventure
  belongs_to :user
  validates :tagline, :content, :rating, presence: true
  validates :content, length: { maximum: 600 }
  validates :user, uniqueness: { scope: :adventure,
    notice: "You already left a review for this adventure." }

  has_many_attached :photos

end
