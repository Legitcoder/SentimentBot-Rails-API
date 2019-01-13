class Team < ApplicationRecord
  has_many :users
  belongs_to :user, optional: true
  has_many :surveys

  before_validation :ensure_team_code_uniqueness

  def generate_code
    rand.to_s[2..6].to_i
  end

  def ensure_team_code_uniqueness
    if Team.find_by(code: self.code)
      self.code = Team.generate_code
      self.save
    end
  end

end



