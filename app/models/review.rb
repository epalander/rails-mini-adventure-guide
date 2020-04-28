class Review < ApplicationRecord
  belongs_to :adventures
  belongs_to :users

  has_many_attached :photos
end
