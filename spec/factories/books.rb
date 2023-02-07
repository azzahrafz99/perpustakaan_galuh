FactoryBot.define do
  factory :book do
    association :category

    title     { Faker::Book.title }
    author    { Faker::Book.author }
    publisher { Faker::Book.publisher }
    summary   { Faker::Lorem.paragraph }
    isbn      { Faker::Number.number(digits: 10) }
    stock     { 1 }
  end
end
