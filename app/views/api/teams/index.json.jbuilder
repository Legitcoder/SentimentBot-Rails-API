json.array!(@teams) do |team|
  json.(team, :id, :team_name, :code)
  json.survey team.surveys.first, :id, :schedule, :feelings, :time, :start_date, :team_id if team.surveys
  json.users team.users, :id, :first_name, :last_name, :email, :team_id, :image_url, :is_admin, :phone, :subscribed, :is_team_member if team.users
end