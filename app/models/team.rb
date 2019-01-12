class Team < ApplicationRecord
  has_many :users
  belongs_to :user, optional: true
  has_many :surveys
end
