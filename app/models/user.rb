class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :password, presence: true, length: { in: 7..32 }, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true
  VALID_NAME_REGEX = /\A[a-zA-Z ,.'-]+\z/
  validates :first_name, presence: true, length: { in: 1..50 }, format: { with: VALID_NAME_REGEX, message: 'only allows letters' }
  validates :last_name, presence: true, length: { in: 1..50 }, format: { with: VALID_NAME_REGEX, message: 'only allows letters' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  has_many :memberships, foreign_key: :user_id, dependent: :destroy
  has_many :groups, foreign_key: :creator_id, class_name: 'Group'
  has_many :groups, through: :memberships
  has_many :activities, foreign_key: :author_id, class_name: 'Activity', dependent: :destroy
end
