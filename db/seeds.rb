# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emojis = ["😄" ,"😃","😢","😊","😞", "😡"]

moin = User.create(email: "moin@moin.com", first_name: "moin", last_name: "uddin", is_admin: true, password: "123456", phone: "123-456-7890")


triggers = ["daily", "weekly", "monthly"]

managers = [moin]

for _ in 0..10
  manager = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Lorem.word, is_admin: true, phone: Faker::PhoneNumber.phone_number, image_url: Faker::Avatar.image)
  managers << manager
  manager.save()
end

teams = []

moinsTeam = Team.create(team_name: "Moin's team", user: moin)

moinSurvey = Survey.find_by(team_id: moinsTeam.id)

for _ in 0..5
  feeling = Feeling.create(mood: Faker::Lorem.word, emoji: emojis.sample, survey: moinSurvey)
end

moinSurvey.save()

teams << moinsTeam
moin.save()

for _ in 0..20
  team = Team.create(team_name: Faker::Lorem.word, user: managers.sample)
  teams << team
  team.save()
end


surveys = []

for _ in 0..200
  survey = Survey.create(schedule: triggers.sample, team: teams.sample, question: Faker::Lorem.sentence)
  surveys << survey
  survey.save()
end

users = []

scott = User.create(team: moinsTeam, first_name: "Scott", last_name: "Bennet", email: "scott@scott.com", password: "123456", is_admin: false, is_team_member: true, phone: Faker::PhoneNumber.phone_number, image_url: Faker::Avatar.image)
scott.save()

for _ in 0 ..10
  response = Response.create(mood: Faker::Lorem.word, emoji: emojis.sample, survey: moinSurvey, user: scott, longitude: Faker::Address.longitude, latitude: Faker::Address.latitude, date: Faker::Date.backward(100), image_url: Faker::Avatar.image, place: "#{Faker::Address.city}, #{Faker::Address.state}")
  
  response.save()
end
for _ in 0..200
  user = User.create(team: teams.sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Lorem.word, is_admin: false, is_team_member: true, phone: Faker::PhoneNumber.phone_number, image_url: Faker::Avatar.image)
  users << user
  user.save()
end

feelings = []

for _ in 0..50
  feeling = Feeling.create(mood: Faker::Lorem.word, emoji: emojis.sample, survey: surveys.sample)
  feelings << feeling
  feeling.save()
end

responses = []

for _ in 0..400
  response = Response.create(mood: Faker::Lorem.word, emoji: emojis.sample, survey: surveys.sample, user: users.sample, longitude: -73.935242, latitude: 40.730610, date: Faker::Date.backward(100), image_url: Faker::Avatar.image, place: "#{Faker::Address.city}, #{Faker::Address.state}")
  responses << response
  response.save()
end


# team = Team.create(team_name: "Team A")
# team.user = moin
# team.save()