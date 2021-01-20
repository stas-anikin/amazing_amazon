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
PASSWORD = "123"
super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  is_admin: true,
)
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}.#{last_name}@gmail.com",
    password: PASSWORD,
  )
end
2.times do
  title = Faker::Name.first_name
  description = Faker::Name.last_name
  NewsArticle.create(
    title: title,
    description: description,
    published_at: Faker::Date.forward(days: 23),
    created_at: Faker::Date.backward(days: 14),
  )
end
users = User.all
50.times do
  price = rand(100)
  p = Product.create(
    title: Faker::Commerce.product_name,
    description: Faker::Hipster.sentence,
    price: price,
    user: users.sample,
  )
  if p.valid?
    p.reviews = rand(1..10).times.map do
      Review.new(
        body: Faker::Hipster.paragraph,
        rating: rand(1..5),
        user: users.sample,
      )
    end
  end
end
product = Product.all
review = Review.all
news_article = NewsArticle.all
puts "Generated #{product.count} products, #{news_article.count} articles, #{users.count} users, #{review.count} reviews."
