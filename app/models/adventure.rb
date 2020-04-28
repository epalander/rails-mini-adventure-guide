class Adventure < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :reviews

  def avg_rating
    self.reviews.average(:rating)
  end

  include PgSearch::Model
  pg_search_scope :search_by_title_and_category,
    against: [ :title, :category ],
    using: {
      tsearch: { prefix: true }
    }
end
