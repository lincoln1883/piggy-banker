require 'rails_helper'

RSpec.describe 'CategoriesController', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  before do
    sign_in user
  end

  describe 'GET /categories' do
    it 'renders the index template' do
      get categories_path
      expect(response).to render_template(:index)
    end

    it 'displays categories' do
      category
      get categories_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(category.name)
    end
  end

  describe 'GET /categories/new' do
    it 'renders the new template' do
      sign_in(user)
      get new_category_path
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /categories' do
    it 'creates a new category' do
      sign_in(user)
      category_params = attributes_for(:category)
      expect do
        post categories_path, params: { category: category_params }
      end.to change(Category, :count).by(1)

      expect(response).to redirect_to(categories_path)
      follow_redirect!

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Category created successfully!')
    end

    it 'handles invalid category creation' do
      sign_in(user)
      expect do
        post categories_path, params: { category: { name: '' } }
      end.not_to change(Category, :count)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end
end
