# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

Article.delete_all
User.delete_all

30.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1
  Article.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

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
                street: street,
                city: city,
                postal: postal,
                email: email,
                admin: admin)
end

User.create!( name: "Peter Lustig",
              password: "12345678",
              street: "Der Admin-Garten",
              city: "Stadtmin",
              postal: "11111",
              email: "peter@lustig.de",
              admin: true)

OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progess"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled" 


