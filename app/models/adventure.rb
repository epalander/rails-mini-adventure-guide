class Adventure < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  validates :description, length: { maximum: 600 }
  validates :directions, length: { maximum: 300 }
  validates :title, :description, :category, :address, :distance, :youngest_age, :difficulty, :stroller_friendly, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :reviews

  def avg_rating
    self.reviews.average(:rating)
  end

  include PgSearch::Model
  pg_search_scope :search_by_title_description_and_category,
    against: [ :title, :category, :description ],
    using: {
      tsearch: { prefix: true }
    }

  scope :filter_by_parking, -> { where parking: true }
  scope :filter_by_public_transport, -> { where public_transport: true }
  scope :filter_by_stroller_friendly, -> { where stroller_friendly: true }
  scope :filter_by_youngest_age, -> (youngest_age) { where youngest_age: youngest_age }
  scope :filter_by_difficulty, -> (difficulty) { where difficulty: difficulty }
  scope :filter_by_distance, -> (distance) { where distance: distance }
  scope :filter_by_category, -> (category) { where category: category }

end
