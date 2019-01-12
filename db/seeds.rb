# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

moin = User.create(email: "moin@moin.com", first_name: "moin", last_name: "uddin", is_admin: true, password: "123456")
moin.save()

users = [moin]

for _ in 0..500
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Lorem.word, is_admin: false)
  users << user
end

#Save each user
users.each do |user|
  user.save()
end

# team = Team.create(team_name: "Team A")
# team.user = moin
# team.save()