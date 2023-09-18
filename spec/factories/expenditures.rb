FactoryBot.define do
  factory :expenditure do
    sequence(:name) { |n| "Expenditure #{n}" }
    amount { Faker::Number.decimal(l_digits: 2) }
    category
    user
  end
end
