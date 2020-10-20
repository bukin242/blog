FactoryBot.define do
  factory :comment do
    sequence(:text) { |n| "Text #{n}" }
    expires_at { DateTime.current + 15.minutes }

    association :post
    association :user
  end
end
