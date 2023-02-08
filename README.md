# Perpustakaan Galuh
## Table of Content
- [Technologies](#technologies)
- [Requirements](#requirements)
- [Local Setup](#local-setup)
## Technologies
- Ruby 3.0.0
- Ruby on Rails 6.1.7.2
- Postgres >= 13.1
- Test: RSpec, Capybara, Selenium, Database Cleaner
- Gems
  - devise
  - factory_bot_rails
  - faker
  - letter_opener
  - pg
  - pry
  - puma
  - pundit
  - rails
  - rolify
  - rspec
  - rubocop
  - sass-rails
  - shoulda
  - shoulda-matchers
  - simplecov
  - timecop
  - webpacker

## Requirements
These should be installed before you get started:
- Ruby version 3.0.0
- Bundler
- Postgres >= 13.1
- Git
- NodeJS
## Local Setup
1. Run `bundle install`.
2. Install yarn `brew install yarn` or `nvm install yarn`
3. Run `yarn`
4. Run `rake db:setup db:test:prepare` to setup databases.
5. Run `rake db:migrate` to setup tables on the database.
6. Run `rake db:seed`

  I have added seed file to create users, categories, and books.
  - You can use this user if you want to login as admin:
    - email: `admin@sample.com`
    - password: `passwordadmin`

  - You can use this user if you want to login as user:
    - email: `user@sample.com`
    - password: `passworduser`
7. Run `bin/webpack-dev-server`
8. Run `rails s` to run Rails server in development.
9. Run `rspec spec/` to run testing. After this, it will generates `coverage/` directory inside project's directory. You can see the testing coverage inside `coverage/index.html`
