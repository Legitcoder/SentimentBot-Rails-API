class Team < ApplicationRecord
  has_many :users
  belongs_to :manager, class_name: "User", foreign_key: :manager_id
  has_many :surveys
end
