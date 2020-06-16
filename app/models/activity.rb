class Activity < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :calories, presence: true, numericality: { greater_than: 0}
end