require 'rails_helper'

RSpec.describe TransactionsController, type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  before do
    sign_in(user)
  end

  describe 'GET /categories/:category_id/transactions' do
    it 'displays a list of transactions for a category' do
      transaction1 = create(:transaction, category: category, user: user)
      transaction2 = create(:transaction, category: category, user: user)
      transaction3 = create(:transaction, category: category, user: user)

      get category_transactions_path(category)

      expect(response).to have_http_status(:success)
      expect(response.body).to include(transaction1.name)
      expect(response.body).to include(transaction2.name)
      expect(response.body).to include(transaction3.name)
    end
  end


  describe 'GET /categories/:category_id/transactions/new' do
    it 'displays the new transaction form' do
      get new_category_transaction_path(category)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /categories/:category_id/transactions' do
    it 'creates a new transaction' do
      transaction_attributes = attributes_for(:transaction)
      post category_transactions_path(category), params: { transaction: transaction_attributes }

      expect(response).to redirect_to(categories_path)
      expect(flash[:notice]).to eq('Transaction created successfully.')
      expect(Transaction.last.name).to eq(transaction_attributes[:name])
    end
  end
end
