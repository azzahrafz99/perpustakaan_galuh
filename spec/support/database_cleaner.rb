RSpec.configure do |config|
  if Rails.env.test?
    # https://github.com/DatabaseCleaner/database_cleaner#safeguards
    DatabaseCleaner.allow_remote_database_url = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  # This block must be here, do not combine with the other `before(:each)` block.
  # This makes it so Capybara can see the database.
  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
