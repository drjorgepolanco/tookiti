User.create!(first_name: 'Julito',
	           last_name:  'Triculi',
	           email:      'triculito@mail.com',
	           password:              'password',
	           password_confirmation: 'password',
	           admin:      true,
	           activated:  true,
	           activated_at: Time.zone.now)

99.times do |n|
first_name = Faker::Name.first_name
last_name  = Faker::Name.last_name
email      = "example-#{n+1}@railstutorial.org"
password   = 'password'
User.create!(first_name: first_name, last_name: last_name, email: email,
	           password: password, password_confirmation: password,
	           activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
21.times do
	title = "#{Faker::Lorem.word} #{Faker::Lorem.word}" 
	image = File.open(File.join(Rails.root, 'test/fixtures/files/krake.jpg'))
	users.each { |user| user.posts.create!(title: title, image: image) }
end

users = User.order(:created_at).take(6)
15.times do
	title  = "#{Faker::Lorem.word} #{Faker::Lorem.word} #{Faker::Lorem.word}"
	poster = 'http://media-cache-ec0.pinimg.com/736x/1c/08/20/1c08202b325a1058b0e3d1bf8636dc51.jpg'
	users.each { |user| user.contests.create!(title: title, poster: poster) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
