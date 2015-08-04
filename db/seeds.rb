# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

Article.delete_all
30.times do |n|
  name = FFaker::Food.meat
  description = FFaker::Food.ingredient
  price = n + 1
  Article.create(name: name,
                  description: description,
                  price: price,
                  isVegetarian: false)
end
