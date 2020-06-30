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

  has_many :groups, through: :memberships
  has_many :groups, foreign_key: :creator_id, class_name: 'Group'
  has_many :memberships, foreign_key: :user_id, dependent: :destroy
  has_many :activities, foreign_key: :author_id, class_name: 'Activity'

  scope :recent_activities_all, ->(user) { user.activities.where('author_id = ? AND created_at >= ?', user.id, Date.today - 28).order(created_at: :desc) }
  scope :recent_activities7, ->(user) { user.activities.where('author_id = ? AND created_at >= ?', user.id, Date.today - 7) }
  scope :recent_activities14, ->(user) { user.activities.where('created_at BETWEEN ? AND ?', Date.today - 14, Date.today - 7) }
  scope :recent_activities21, ->(user) { user.activities.where('created_at BETWEEN ? AND ?', Date.today - 21, Date.today - 14) }
  scope :recent_activities28, ->(user) { user.activities.where('created_at BETWEEN ? AND ?', Date.today - 28, Date.today - 21) }
  scope :undiscovered_groups, ->(user) { Group.all.where('id NOT IN (?)', user.memberships.map(&:group_id)) }
  scope :joined_groups, ->(user) { Group.all.where('id IN (?)', user.memberships.map(&:group_id)) }

  def user_name
    "#{first_name} " + last_name.to_s
  end

  def user_id
    id
  end

  def author_name
    "#{first_name} " + last_name.to_s
  end
end
