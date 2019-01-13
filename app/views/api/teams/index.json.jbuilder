json.array!(@teams) do |team|
  json.(team, :id, :team_name, :code)
  json.user team.user, :id, :first_name, :last_name, :email, :phone
  json.surveys team.surveys, :id, :schedule
end