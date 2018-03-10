FactoryBot.define do
  factory :user do
    email('octavianrotari@example.com')
    password('password')
    password_confirmation('password')
  end
end
