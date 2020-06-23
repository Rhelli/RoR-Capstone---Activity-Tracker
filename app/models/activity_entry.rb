class ActivityEntry < ApplicationRecord
  belongs_to :activity
  belongs_to :group
  validates :activity, presence: true
  validates :group, presence: true
end
