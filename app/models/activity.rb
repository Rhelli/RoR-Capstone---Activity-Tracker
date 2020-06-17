class Activity < ApplicationRecord
  validates :name, presence: true, length: { in: 1..120 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :calories, presence: true, numericality: { greater_than: 0}

  has_one :activity_entry, foreign_key: :activity_id
  has_many :groups, through: :activity_entries
  belongs_to :author, class_name: 'User'
end