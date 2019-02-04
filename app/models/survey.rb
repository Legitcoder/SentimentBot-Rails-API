class Survey < ApplicationRecord
  belongs_to :team
  has_many :feelings, dependent: :destroy

  before_create do
    self.start_date = Date.today unless self.start_date
  end

end
