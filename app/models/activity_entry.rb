class ActivityEntry < ApplicationRecord
  belongs_to :activity, dependent: :destroy
  belongs_to :group
  validates :activity, presence: true
  validates :group, presence: true

  scope :recent_group_activity, ->(group) { where('group_id = ? AND created_at >= ?', group.id, Date.today - 7).count }
end
