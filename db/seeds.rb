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
              email: "peter@lustig.de",
              password: "12345678",
              street: "Der Admin-Garten",
              city: "Stadtmin",
              postal: "11111",
              admin: true)

User.create!( name: "Peter Unlustig",
              email: "normal@user.de",
              password: "12345678",
              street: "Der Admin-Garten",
              city: "Stadtmin",
              postal: "11111",
              admin: false)

Category.delete_all

@category = Category.create! name: "Vorspeise"
6.times do |n|
  name = FFaker::Food.meat
  description = "This is a very long description. In fact, it is so long, that
  Foodle will hopefully not display its full text. Usually a description
  contains ingredients and things like that. Now have som bla's: bla bla bla."
  price = n + 1.00
  @category.articles.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

@category = Category.create! name: "Salat"
6.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1.00
  @category.articles.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

@category = Category.create! name: "Pizza"
6.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1.00
  @category.articles.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

@category = Category.create! name: "Pasta"
6.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1.00
  @category.articles.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

Category.create! name: "Lasagne"
@category = Category.create! name: "Schwein"
6.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1.00
  @category.articles.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

Category.create! name: "Rind"
@category = Category.create! name: "Geflügel"
6.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1.00
  @category.articles.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

@category = Category.create! name: "Dessert"
6.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1.00
  @category.articles.create!(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end

OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Erstellung"
OrderStatus.create! id: 2, name: "Abgeschickt"
OrderStatus.create! id: 3, name: "In Bearbeitung"
OrderStatus.create! id: 4, name: "Abgeschickt"
OrderStatus.create! id: 5, name: "Storniert"

# 30.times do |n|
#   name = FFaker::Food.meat
#   description = FFaker::Food.ingredient
#   price = n + 1.00
#   Article.create!(name: name,
#                   description: description,
#                   price: price,
#                   isVegetarian: false)
# end
