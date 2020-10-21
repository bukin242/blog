FactoryBot.define do
  factory :comment do
    sequence(:text) { |n| "Text #{n}" }

    association :post
    association :user
  end
end
