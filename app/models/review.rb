class Review < ApplicationRecord
  belongs_to :adventure
  belongs_to :user
  validates :tagline, :content, :rating, presence: true

  has_many_attached :photos
end
