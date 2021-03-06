class Activity < ApplicationRecord
  validates :name, presence: true, length: { in: 1..120 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :calories, presence: true, numericality: { greater_than: 0 }

  has_one :activity_entry, foreign_key: :activity_id, dependent: :destroy
  has_one :group, through: :activity_entry
  belongs_to :author, class_name: 'User'

  delegate :group_icon, to: :group, allow_nil: false
  delegate :group_name, to: :group, allow_nil: false
  delegate :author_name, to: :user, allow_nil: false
end
