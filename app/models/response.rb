class Response < ApplicationRecord
  belongs_to :survey, optional: true
  belongs_to :user
end
