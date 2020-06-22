class Activity < ApplicationRecord
  validates :name, presence: true, length: { in: 1..120 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :calories, presence: true, numericality: { greater_than: 0}

  has_one :activity_entry, inverse_of: :activity
  accepts_nested_attributes_for :activity_entry
  has_one :groups, through: :activity_entry
  belongs_to :author, class_name: 'User'
end