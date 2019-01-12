class Survey < ApplicationRecord
  belongs_to :team
  has_many :feelings
end
