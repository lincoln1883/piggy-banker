require 'rails_helper'

RSpec.describe Expenditure, type: :model do
  it 'is valid with a name, category_id, and a positive amount' do
    user = FactoryBot.create(:user, full_name: ' John Doe', email: 'john@email.com', password: 'password')
    category = FactoryBot.create(:category, name: 'transit', icon: 'https://picsum.photos/200')
    transaction = FactoryBot.build(:transaction, name: 'Taxi', category_id: category.id, amount: 20, user_id: user.id)
    expect(transaction).to be_valid
  end

  it 'is invalid without a category_id' do
    transaction = FactoryBot.build(:transaction, category_id: nil)
    expect(transaction).to_not be_valid
  end
end
