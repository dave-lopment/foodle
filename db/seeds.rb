# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

# Article.delete_all
# User.delete_all
# Category.delete_all
# OrderStatus.delete_all

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
                  street: street,
                  city: city,
                  postal: postal,
                  email: email,
                  admin: admin)
  end
end

if (User.find_by(name: "Peter Lustig") == nil)
  User.create!( name: "Peter Lustig",
                email: "peter@lustig.de",
                password: "12345678",
                street: "Der Admin-Garten 1",
                city: "Stadtmin",
                postal: "11111",
                admin: true)
end


if (User.find_by(email: "peter@unlustig.de") == nil)
  User.create!( name: "Peter Unlustig",
                email: "peter@unlustig.de",
                password: "12345678",
                street: "Der Normale-User-Garten 99",
                city: "Stadt",
                postal: "11111",
                admin: false)
end

if (Category.find_by(name: "Vorspeise") == nil)
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
  end unless(@category.articles.count > 0)
end

if (Category.find_by(name: "Salat") == nil)
  @category = Category.create! name: "Salat"
  6.times do |n|
    name = FFaker::Food.meat
    description = FFaker::Food.ingredient
    price = n + 1.00
    @category.articles.create!(name: name,
                    description: description,
                    price: price,
                    isVegetarian: false)
  end unless(@category.articles.count > 0)
end

if (Category.find_by(name: "Pizza") == nil)
  @category = Category.create! name: "Pizza"
  6.times do |n|
    name = FFaker::Food.meat
    description = FFaker::Food.ingredient
    price = n + 1.00
    @category.articles.create!(name: name,
                    description: description,
                    price: price,
                    isVegetarian: false)
  end unless(@category.articles.count > 0)
end

if (Category.find_by(name: "Pasta") == nil)
  @category = Category.create! name: "Pasta"
  6.times do |n|
    name = FFaker::Food.meat
    description = FFaker::Food.ingredient
    price = n + 1.00
    @category.articles.create!(name: name,
                    description: description,
                    price: price,
                    isVegetarian: false)
  end unless(@category.articles.count > 0)
end

Category.create! name: "Lasagne" unless(Category.find_by(name: "Lasagne") != nil)

if (Category.find_by(name: "Schwein") == nil)
  @category = Category.create! name: "Schwein"
  6.times do |n|
    name = FFaker::Food.meat
    description = FFaker::Food.ingredient
    price = n + 1.00
    @category.articles.create!(name: name,
                    description: description,
                    price: price,
                    isVegetarian: false)
  end unless(@category.articles.count > 0)
end

if (Category.find_by(name: "Rind") == nil)
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
    end unless(@category.articles.count > 0)
end

if (Category.find_by(name: "Dessert") == nil)
  @category = Category.create! name: "Dessert"
    6.times do |n|
      name = FFaker::Food.meat
      description = FFaker::Food.ingredient
      price = n + 1.00
      @category.articles.create!(name: name,
                      description: description,
                      price: price,
                      isVegetarian: false)
    end unless(@category.articles.count > 0)
end

unless OrderStatus.all.count > 0
  OrderStatus.create! name: "In Erstellung"
  OrderStatus.create! name: "Auftrag"
  OrderStatus.create! name: "Abgeschickt"
  OrderStatus.create! name: "Angekommen"
  OrderStatus.create! name: "Storniert"
end

# 30.times do |n|
#   name = FFaker::Food.meat
#   description = FFaker::Food.ingredient
#   price = n + 1.00
#   Article.create!(name: name,
#                   description: description,
#                   price: price,
#                   isVegetarian: false)
# end
