# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Jang Nara",
             email: "leductienttkt@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Nara",
             email: "le.duc.tien@framgia.com",
             password:              "123456",
             password_confirmation: "123456",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "jang-#{n+1}@nara.love"
  password = "123456"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
20.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..30]
followers = users[3..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

microposts = Micropost.order(:created_at).take(10)
10.times do
  content = Faker::Lorem.sentence(5)
  microposts.each { |micropost| micropost.comments.create!(content: content, user_id: micropost.user.id) }
end
