RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed
  end

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner.strategy = :truncation
    Rails.application.load_seed
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
