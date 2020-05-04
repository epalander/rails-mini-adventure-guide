class Adventure < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  validates :description, length: { maximum: 600 }
  validates :directions, length: { maximum: 300 }
  validates :title, :description, :category, :address, :distance, :youngest_age, :difficulty, presence: true
  validates :stroller_friendly, inclusion: { in: [true, false] }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def avg_rating
    if self.reviews.empty?
      0
    else
      self.reviews.average(:rating)
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by_title_description_address_and_category,
    against: [ :title, :category, :description, :address ],
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
  scope :filter_by_address, -> (address) { where address: address }
  scope :filter_by_avg_duration, -> (avg_duration) { where avg_duration: avg_duration }
end
