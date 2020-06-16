class Group < ApplicationRecord
  VALID_NAME_REGEX = /\A[a-zA-Z\d]+\z/
  validates :name, presence: true, format: { with: VALID_NAME_REGEX, message: 'can only contain letters' }, length: { in: 3..50 }, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 80 }, allow_blank: true

  has_many :activities
  has_many :members
  belongs_to :creator, class_name: 'User'
end
