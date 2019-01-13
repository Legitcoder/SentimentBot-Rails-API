json.array!(@teams) do |team|
  json.(team, :id, :team_name, :code)
  json.user team.user, :id, :first_name, :last_name, :email, :phone if team.user
  json.surveys team.surveys, :id, :schedule, :question if team.surveys
  json.responses team.responses, :id, :emoji, :mood, :longitude, :latitude, :date  if team.responses
  json.users team.users, :id, :first_name, :last_name, :email, :phone if team.users
end