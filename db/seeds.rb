# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all()
User.destroy_all()
Review.destroy_all()

10.times do
  User.create(
    first_name: Faker::Movies::Departed.actor,
    last_name: Faker::Movies::Departed.character,
    email: Faker::Movies::Departed.quote,
  )
end

50.times do
  price = rand(100)
  p = Product.create(
    title: Faker::Games::Fallout.character,
    description: Faker::Games::Fallout.quote,
    price: price,
  )
  if p.valid?
    p.reviews = rand(1..10).times.map do
      Review.new(body: Faker::TvShows::HowIMetYourMother.quote, rating: rand(1..5))
    end
  end
end
user = User.all
product = Product.all
review = Review.all

puts "Generated #{product.count} products, #{user.count} users, #{review.count} reviews."
