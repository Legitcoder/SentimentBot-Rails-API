class User < ApplicationRecord
  has_secure_password


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: VALID_EMAIL_REGEX}
  validates :first_name, :last_name, presence: true


  belongs_to :team, optional: true
  has_many :teams, dependent: :destroy
  has_many :users, through: :teams
  has_many :responses, dependent: :destroy
end
