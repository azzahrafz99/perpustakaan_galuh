# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Roles
%w{admin user}.each do |role|
  Role.find_or_create_by(name: role)
end

# Admin
admin = User.find_by(email: 'admin@sample.com')
unless admin
  admin = User.new \
    email: 'admin@sample.com', password: 'passwordadmin',
    password_confirmation: 'passwordadmin', first_name: 'Admin'

  admin.save
  admin.add_role(:admin)
end

# User
user = User.find_by(email: 'user@sample.com')
unless user
  user = User.new \
    email: 'user@sample.com', password: 'passworduser',
    password_confirmation: 'passworduser', first_name: 'User'

  user.save
  user.add_role(:user)
end

# Categories
['Fiction', 'Non-Fiction'].each do |category|
  Category.find_or_create_by(name: category)
end

# Books
fiction_category     = Category.find_by(name: 'Fiction')
non_fiction_category = Category.find_by(name: 'Non-Fiction')

5.times do
  FactoryBot.create :book, category: non_fiction_category
end

5.times do
  FactoryBot.create :book, category: fiction_category
end
