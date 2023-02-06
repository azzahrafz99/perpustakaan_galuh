FactoryBot.define do
  factory :transaction do
    association :user
    association :book
  end
end
