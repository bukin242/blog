FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@example.com" }
    sequence(:name) { |n| "Name #{n}" }
    password { "password" }
  end
end
