# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Generate users with name "user1" and email "user1@mail.com" up to "user20". The passwords are "123456".
def gen_users 
	num = (1..20).to_a
	users = num.map {|n| "user" + n.to_s}
	emails = users.map {|e| e + "@mail.com" }

	# Create user1 - user20
	num.each{ |n| User.create(email: emails[n - 1], password: "123456", password_confirmation: "123456", username: users[n - 1]) }

	# Sets user1's role to admin.
	user1 = User.find_by(username: "user1")
	user1.update(role: 1)
end

# Generate products
def rand_enum(enum)
	max = Product.send(enum).count - 1
	return rand(0..max)
end

def gen_products
	60.times do
		Product.create(
			user_id: User.last(20).sample.id,
			price: rand(1..1000) * 0.1,
			sale_or_rent: rand_enum(:sale_or_rents),
			description: FFaker::HipsterIpsum.paragraph,
			title: FFaker::Book.title,
			category: rand_enum(:categories),
			format: rand_enum(:formats),
			language: rand_enum(:languages),
			publisher: FFaker::Book.author + " Inc.",
			publication_city: FFaker::Address.city,
			publication_date: FFaker::IdentificationESCO.expedition_date,
			author: FFaker::Book.author,
			discount: 0.step(50, 5).to_a.sample,
			ages: "12",
			isbn: FFaker::Book.isbn,
			stock: rand(1..50) * 10,
			pages: rand(50..1000)
		)
	end
end

def gen_profiles
	users = User.last(20)
	users.each do |user|
		user.profile.update(
			name: FFaker::Name.name,
			avatar: FFaker::Avatar.image,
			description: FFaker::BaconIpsum.paragraph,
			address: FFaker::Address.street_address,
			birthdate: FFaker::IdentificationESCO.expedition_date - (365 * rand(10..30)),
			whatsapp: [true, false].sample,
			phone: FFaker::PhoneNumber.phone_number
		)
	end
end

def update_academic
	products = Product.last(60)
	products.each do |product|
		if Product.categories[product.category] <= 5
			product.update(title: FFaker::Education.major)
		end 
	end
end

def gen_rent_duration
	products_sell = Product.where(sale_or_rent: 0)
	products_rent = Product.where(sale_or_rent: 1)

	products_sell.each do |p|
		p.update(duration: 1)
	end

	products_rent.each do |p|
		p.update(duration: [1, 3, 6].sample)
	end
end


# Uncomment generators below to run ================================

# gen_users
# gen_profiles
# gen_products
# update_academic
gen_rent_duration