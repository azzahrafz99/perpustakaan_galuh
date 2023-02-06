FactoryBot.define do
  factory :book do
    title     { Faker::Book.title }
    author    { Faker::Book.author }
    publisher { Faker::Book.publisher }
    summary   { Faker::Lorem.paragraph }
    book_code { Faker::Number.number(digits: 10) }
  end
end
