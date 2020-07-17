class User < ApplicationRecord
  has_many :reviews

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
     :recoverable, :rememberable, :trackable

  validates_presence_of     :email # optional
  validates_uniqueness_of   :email # required
  validates_presence_of     :username # required
  validates_uniqueness_of   :username # required
  validates_presence_of     :password, if: :password_required? # recommended
  validates_confirmation_of :password, if: :password_required? # recommended
  validates_length_of       :password, within: 6..128, allow_blank: true # recommended
end
