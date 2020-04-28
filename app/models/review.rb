class Review < ApplicationRecord
  belongs_to :adventure
  belongs_to :user

  has_many_attached :photos
end
