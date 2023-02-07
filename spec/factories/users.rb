FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { 'password' }
    password_confirmation { 'password' }

    after(:create) { |user| user.add_role(:user) }
  end

  factory :admin, class: 'User' do
    email                 { Faker::Internet.email }
    password              { 'password' }
    password_confirmation { 'password' }

    after(:create) { |user| user.add_role(:admin) }
  end
end
