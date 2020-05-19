require 'set'

class Adventure < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  validates :description, length: { maximum: 1000 }
  validates :directions, length: { maximum: 600 }
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

  # def avg_difficulty
  #   if self.reviews.empty?
  #     self.difficulty
  #   else
  #     (self.difficulty + self.reviews.sum(:difficulty)).fdiv(self.reviews.count + 1).round
  #   end
  # end

  def crowdsource_stats
    age = ["under < 1 year", "1-3 years", "4-6 years", "7-11 years", "12-15 years", "16+ years"]
    level = ["Easy", "Moderate", "Challenging"]

    if self.reviews.empty?
      stats = {
        avg_rating: 0,
        avg_difficulty: level[self.difficulty],
        avg_age: age[self.youngest_age],
        avg_duration: self.avg_duration,
        num_ratings: 0
      }
    else
      stats = {
        avg_rating: self.reviews.average(:rating),
        avg_difficulty: level[(self.difficulty + self.reviews.sum(:difficulty)).fdiv(self.reviews.count + 1).round],
        avg_age: age[(self.youngest_age + self.reviews.sum(:youngest_age)).fdiv(self.reviews.count + 1).round],
        num_ratings: self.reviews.count,
        avg_duration: 0 ##program this later...
      }
    end
  end

  def rand_n(n, max)
    randoms = Set.new
    loop do
        randoms << rand(max)
        return randoms.to_a if randoms.size >= n
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
