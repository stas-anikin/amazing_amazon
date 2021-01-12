# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all()
User.destroy_all()

10.times do
  User.create(
    first_name: Faker::Movies::Departed.actor,
    last_name: Faker::Movies::Departed.character,
    email: Faker::Movies::Departed.quote,
  )
end

10.times do
  price = rand(100)
  Product.create(
    title: Faker::Games::Fallout.character,
    description: Faker::Games::Fallout.quote,
    price: price,
  )
end
user = User.all
product = Product.all

puts "Generated #{product.count} products."
puts "Generated #{user.count} users."
