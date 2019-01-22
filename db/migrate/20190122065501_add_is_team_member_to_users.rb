class AddIsTeamMemberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_team_member, :boolean, default: false
  end
end
