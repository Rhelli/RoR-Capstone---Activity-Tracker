class Group < ApplicationRecord
  VALID_NAME_REGEX = /\A[a-zA-Z\d]+\z/
  validates :name, presence: true, format: { with: VALID_NAME_REGEX, message: 'can only contain letters' }, length: { in: 3..50 }, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 80 }, allow_blank: true
end
