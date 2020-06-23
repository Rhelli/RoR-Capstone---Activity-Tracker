class Group < ApplicationRecord
  VALID_NAME_REGEX = /\A[a-zA-Z\d ,.'-]+\z/
  validates :name, presence: true, format: { with: VALID_NAME_REGEX, message: 'can only contain letters' }, length: { in: 3..50 }, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 80 }, allow_blank: true

  belongs_to :creator, class_name: 'User'
  has_many :memberships
  has_many :users, through: :memberships
  has_many :activity_entries, foreign_key: :group_id
  has_many :activities, through: :activity_entries=

  def group_icon
    self.icon.html_safe
  end

  def group_name
    self.name
  end

  def group_description
    self.description
  end

  def group_age
    self.created_at
  end

  def group_id
    self.id
  end
end
