# frozen_string_literal: true

# Creates an admin User
User.create!(name: 'Admin',
             email: 'agustin@admin.com',
             password: '12341234',
             password_confirmation: '12341234',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)


# Creates 51 users
51.times do
  name = Faker::Name.name
  email = Faker::Internet.email
  password = '12341234'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.all
users.each do |user|
  content = Faker::Lorem.sentence(word_count: 4)
  user.microposts.create!(content: content)
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
