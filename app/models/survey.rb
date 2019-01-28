class Survey < ApplicationRecord
  belongs_to :team
  has_many :feelings, dependent: :destroy
end
