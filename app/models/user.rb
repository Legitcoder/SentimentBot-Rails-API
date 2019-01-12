class User < ApplicationRecord
  has_secure_password
  belongs_to :team, optional: true
  has_many :teams
  has_many :users
  has_many :responses
end
