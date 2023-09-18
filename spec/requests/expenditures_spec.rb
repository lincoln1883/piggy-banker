require 'rails_helper'

RSpec.describe ExpendituresController, type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  before do
    sign_in(user)
  end

  describe 'GET /categories/:category_id/expenditures' do
    it 'displays a list of expenditures for a category' do
      expenditure1 = create(:expenditure, category:, user:)
      expenditure2 = create(:expenditure, category:, user:)
      expenditure3 = create(:expenditure, category:, user:)

      get category_expenditures_path(category)

      expect(response).to have_http_status(:success)
      expect(response.body).to include(expenditure1.name)
      expect(response.body).to include(expenditure2.name)
      expect(response.body).to include(expenditure3.name)
    end
  end

  describe 'GET /categories/:category_id/expenditures/new' do
    it 'displays the new expenditure form' do
      get new_category_expenditure_path(category)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /categories/:category_id/expenditures' do
    it 'creates a new expenditure' do
      expenditure_attributes = attributes_for(:expenditure)
      post category_expenditures_path(category), params: { expenditure: expenditure_attributes }

      expect(response).to redirect_to(categories_path)
      expect(flash[:notice]).to eq('Expenditure created successfully.')
      expect(Expenditure.last.name).to eq(expenditure_attributes[:name])
    end
  end
end
