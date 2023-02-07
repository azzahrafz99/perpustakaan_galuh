FactoryBot.define do
  factory :transaction do
    association :user
    association :book

    loan_date { Date.current - 2.days }
    period    { 7 }
  end
end
