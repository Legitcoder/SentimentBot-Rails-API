class Team < ApplicationRecord
  has_many :users
  belongs_to :user, optional: true
  has_many :surveys
  has_many :responses, through: :users

  before_validation :ensure_team_code_uniqueness

  def self.generate_code
    rand.to_s[2..6].to_i
  end

  def ensure_team_code_uniqueness
    self.code = Team.generate_code
    if Team.find_by(code: self.code)
      self.code = Team.generate_code
      self.save
    end
  end

end



