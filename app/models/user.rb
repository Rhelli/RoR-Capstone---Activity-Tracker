class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :password_confirmation, presence: true
  validates :password, presence: true, length: { in: 7..32 }, confirmation: { case_sensitive: true }
  validates :first_name, presence: true, length: { in: 1..50 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :last_name, presence: true, length: { in: 1..50 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
