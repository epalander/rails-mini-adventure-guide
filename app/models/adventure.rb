class Adventure < ApplicationRecord
  has_many :reviews

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

  scope :filter_by_parking, -> (parking) { where parking: true }
  scope :filter_by_public_transport, -> (public_transport) { where public_transport: true }
  scope :filter_by_stroller_friendly, -> (stroller_friendly) { where stroller_friendly: true }
  scope :filter_by_youngest_age, -> (youngest_age) { where youngest_age: youngest_age }
  scope :filter_by_difficulty, -> (difficulty) { where difficulty: difficulty }
  scope :filter_by_distance, -> (distance) { where distance: distance }

end
