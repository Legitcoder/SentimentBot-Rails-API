json.array!(@teams) do |team|
  json.(team, :id, :team_name, :code)
  json.user team.user, :id, :first_name, :last_name, :email, :phone if team.user
  json.surveys team.surveys, :id, :schedule if team.surveys
  json.responses team.responses, :id, :emoji if team.responses
  json.users team.users, :id, :first_name, :last_name, :email, :phone if team.users
end