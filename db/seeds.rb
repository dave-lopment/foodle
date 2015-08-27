# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

if User.all.count == 0
  40.times do |n|
    name = FFaker::Name.name
    password = "12345678"
    street = FFaker::AddressDE.street_name
    city = FFaker::AddressDE.city
    postal = FFaker::AddressDE.zip_code
    email = "#{n}" << FFaker::Internet.email

    admin = false
    User.create!( name: name,
                  password: password,
		  password_confirmation: password,
                  street: street,
                  city: city,
                  postal: postal,
                  email: email,
                  admin: admin,
		  confirmed_at: Date.today)
  end
end

if (User.find_by(name: "Peter Lustig") == nil)
  User.create!( name: "Peter Lustig",
                email: "peter@lustig.de",
                password: "12345678",
		password_confirmation: "12345678",
                street: "Der Admin-Garten 1",
                city: "Stadtmin",
                postal: "11111",
                admin: true,
	        confirmed_at: Date.today)
end


if (User.find_by(email: "peter@unlustig.de") == nil)
  User.create!( name: "Peter Unlustig",
                email: "peter@unlustig.de",
                password: "12345678",
		password_confirmation: "12345678",
                street: "Der Normale-User-Garten 99",
                city: "Stadt",
                postal: "11111",
                admin: false,
	        confirmed_at: Date.today)
end

Category.create! name: "Vorspeise" unless(Category.find_by(name: "Vorspeise") != nil)
Category.create! name: "Salat" unless(Category.find_by(name: "Salat") != nil)
Category.create! name: "Pizza" unless(Category.find_by(name: "Pizza") != nil)
Category.create! name: "Pasta" unless(Category.find_by(name: "Pasta") != nil)
Category.create! name: "Lasagne" unless(Category.find_by(name: "Lasagne") != nil)
Category.create! name: "Schwein" unless(Category.find_by(name: "Schwein") != nil)
Category.create! name: "Rind" unless(Category.find_by(name: "Rind") != nil)
Category.create! name: "Geflügel" unless(Category.find_by(name: "Geflügel") != nil)
Category.create! name: "Dessert" unless(Category.find_by(name: "Dessert") != nil)

Category.all.each do |cat| 
  6.times do |n| 
    name = FFaker::Food.meat
    description = "This is a very long description. In fact, it is so long, that
    Foodle will hopefully not display its full text. Usually a description
    contains ingredients and things like that. Now have som bla's: bla bla bla."
    price = n + 1.00
    cat.articles.create!(name: name,
                    description: description,
                    price: price,
                    isVegetarian: false)
  end unless(cat.articles.count > 0)
end 
