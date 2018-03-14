FactoryBot.define do
  factory :user do
    uid('octavianrotari@example.com')
    email('octavianrotari@example.com')
    password('password')
    password_confirmation('password')
  end
end
