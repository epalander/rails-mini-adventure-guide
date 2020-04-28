class Adventure < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :reviews

  def avg_rating
    self.reviews.average(:rating)
  end
end
