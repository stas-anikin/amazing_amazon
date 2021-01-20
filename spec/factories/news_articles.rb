RANDOM_HUNDRED_CHARS = "hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello worldhello world"

FactoryBot.define do
  factory :news_article do
    sequence(:title) { |n| Faker::Job.title + "#{n}" }
    description { Faker::Job.field + "#{RANDOM_HUNDRED_CHARS}" }
    published_at { Faker::Date.forward(days: 14) }
    created_at { Faker::Date.backward(days: 23) }
    view_count { rand(1..1000) }
  end
end

# FactoryBot.create(:news_article) 👈🏻 This will create the object and save it in a db
# FactoryBot.build(:news_article) 👈🏻 This will give us a object lik
