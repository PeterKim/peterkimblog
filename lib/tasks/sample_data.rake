namespace :db do
  desc "fill database with random users"
  task populate: :environment do
    User.create!(name: "Example User",
    		 email: "example@example.com",
		 password: "123456",
		 password_confirmation: "123456"
	        ) 
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
  end   
end	  