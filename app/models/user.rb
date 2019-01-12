class User < ApplicationRecord
  has_secure_password
  belongs_to :team
  has_many :users
  has_many :responses
end
