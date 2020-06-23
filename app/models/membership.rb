class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  delegate :group_name, to: :group, allow_nil: false
  delegate :group_icon, to: :group, allow_nil: false
  delegate :group_age, to: :group, allow_nil: false
  delegate :group_ids, to: :group, allow_nil: false

  scope :my_memberships, ->(user) { where('user_id = ?', user.id).order(created_at: :desc) }
  scope :member_count, ->(group) { where('group_id = ?', group.id).count }
end
