require 'rails_helper'

RSpec.describe CategoriesController do
  let!(:user)  { create(:user) }
  let!(:admin) { create(:admin) }

  let!(:category) { create(:category) }

  describe 'GET index' do
    before do
      sign_in(user)
      get :index
    end

    it 'renders index' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    context 'when get category' do
      before do
        sign_in(user)
        get :show, params: { id: category.id }
      end

      it 'assigns category' do
        expect(assigns(:category)).to eq category
      end
    end
  end

  describe 'GET new' do
    context 'when admin login' do
      before do
        sign_in(admin)
        get :new
      end

      it 'renders new' do
        expect(response).to render_template('new')
      end
    end

    context 'when user login' do
      before do
        sign_in(user)
        get :new
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end

  describe 'POST create' do
    let(:valid_params) do
      { category: { name: 'Fiction' } }
    end

    let(:invalid_params) do
      { category: { name: nil } }
    end

    context 'when admin login' do
      before do
        sign_in(admin)
        post :create, params: params
      end

      context 'when params is valid' do
        let(:params)        { valid_params }
        let(:last_category) { Category.last }

        it 'creates category' do
          expect(last_category.name).to eq 'Fiction'
        end
      end

      context 'when params is invalid' do
        let(:params) { invalid_params }

        it 'renders new' do
          expect(response).to render_template('new')
        end
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        post :create, params: valid_params
      end

      context 'when params is valid' do
        let(:params) { valid_params }

        it_behaves_like 'redirect to dashboard with error message'
      end

      context 'when params is invalid' do
        let(:params) { invalid_params }

        it_behaves_like 'redirect to dashboard with error message'
      end
    end
  end

  describe 'GET edit' do
    context 'when admin login' do
      before do
        sign_in(admin)

        get :edit, params: { id: category.id }
      end

      it 'renders edit' do
        expect(response).to render_template('edit')
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        get :edit, params: { id: category.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end

  describe 'PATCH update' do
    let(:valid_params) do
      { id: category.id, category: { name: 'Fiction' } }
    end

    let(:invalid_params) do
      { id: category.id, category: { name: nil } }
    end

    context 'when admin login' do
      before do
        sign_in(admin)
        patch :update, params: params

        category.reload
      end

      context 'when params is valid' do
        let(:params) { valid_params }

        it 'updates category' do
          expect(category.name).to eq 'Fiction'
        end
      end

      context 'when params is invalid' do
        let(:params) { invalid_params }

        it 'does not updates category' do
          expect(category.name).not_to eq 'Fiction'
        end
      end
    end

    context 'when user login' do
      before do
        sign_in(user)
        post :update, params: params
      end

      context 'when params is valid' do
        let(:params) { valid_params }

        it_behaves_like 'redirect to dashboard with error message'
      end

      context 'when params is invalid' do
        let(:params) { invalid_params }

        it_behaves_like 'redirect to dashboard with error message'
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when admin login' do
      context 'when category is in used' do
        let!(:book) { create(:book, category: category) }

        before do
          sign_in(admin)

          delete :destroy, params: { id: category.id }
        end

        it 'does not remove category' do
          expect(Category.count).to eq 1
        end
      end

      context 'when when category is not in used' do
        before do
          sign_in(admin)

          delete :destroy, params: { id: category.id }
        end

        it 'removes category' do
          expect(Category.count).to be_zero
        end
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        delete :destroy, params: { id: category.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end
end
