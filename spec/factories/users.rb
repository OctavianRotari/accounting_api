FactoryBot.define do
  factory :user do
    uid('octavianrotari@example.com')
    email('octavianrotari@example.com')
    password('password')
    password_confirmation('password')
  end

  factory :user_one, class: 'User' do
    uid('test@example.com')
    email('test@example.com')
    password('password')
    password_confirmation('password')
  end
end
