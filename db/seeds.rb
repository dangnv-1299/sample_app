User.create!(name: "Example User",
  email: "example@railstutorial.org",
  password: "123456",
  password_confirmation: "123456",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)
 # Generate a bunch of additional users.
99.times do |n|
  name = "User #{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end
users = User.order(:created_at).take(6)
  50.times do |n|
  content = "example-#{n+1}@railstutorial.org"
  users.each { |user| user.microposts.create!(content: content) }
end
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
