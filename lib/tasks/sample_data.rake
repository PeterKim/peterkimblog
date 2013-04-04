namespace :db do
  desc "fill database with random users"
  task populate: :environment do
    admin = User.create!(name: "Example User",
    		 email: "example@example.com",
		 password: "123456",
		 password_confirmation: "123456"
	        ) 
    admin.toggle!(:admin)
    99.times do |n|
      name= Faker::Name.name
      email = "example-#{n}@example.com"
      password = "123456"
      User.create!(name: name,
      		   email: email,
		   password: password,
		   password_confirmation: password
		  )   
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end 		
  end   
end	  