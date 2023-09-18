FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    icon { 'https://picsum.photos/200' }
    user

    factory :category_with_expenditures do
      transient do
        expenditures_count { 3 }
      end

      after(:create) do |category, evaluator|
        expenditures = create_list(:expenditure, evaluator.expenditures_count, category:, user: category.user)
        category.update(total_amount: expenditures.sum(&:amount))
      end
    end
  end
end
