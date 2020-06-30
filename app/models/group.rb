class Group < ApplicationRecord
  VALID_NAME_REGEX = /\A[a-zA-Z\d ,.'-]+\z/
  validates :name, presence: true, format: { with: VALID_NAME_REGEX, message: 'can only contain letters' }, length: { in: 3..50 }, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 80 }, allow_blank: true

  belongs_to :creator, class_name: 'User'
  has_many :activity_entries, foreign_key: :group_id, dependent: :destroy
  has_many :activities, through: :activity_entries
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  scope :recent_activities, ->(group) { Activity.where('group_id = ? AND created_at >= ?', group.id, Date.today - 6).order(created_at: :desc).limit(5) }

  def group_icon
    icon.html_safe
  end

  def group_name
    name
  end

  def group_description
    description
  end

  def group_age
    created_at
  end

  def group_id
    id
  end
end
