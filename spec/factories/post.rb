FactoryBot.define do
  factory :post do
    sequence(:name) { |n| "Name #{n}" }
    annonce { "Annonce" }
    text { "Text" }
    active { true }

    association :user
  end
end
