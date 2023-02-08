require 'rails_helper'

RSpec.describe UsersController do
  let!(:user)  { create(:user) }
  let!(:admin) { create(:admin) }

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
    context 'when get user' do
      before do
        sign_in(user)
        get :show, params: { id: user.id }
      end

      it 'assigns user' do
        expect(assigns(:user)).to eq user
      end
    end
  end

  describe 'GET edit' do
    context 'when admin login' do
      before do
        sign_in(admin)

        get :edit, params: { id: user.id }
      end

      it 'renders edit' do
        expect(response).to render_template('edit')
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        get :edit, params: { id: user.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end

  describe 'PATCH update' do
    let(:valid_params) do
      {
        id: user.id,
        user: {
          email: 'test@sample.com',
          first_name: 'Foo', last_name: 'Bar',
          birthdate: Date.new(1999, 0o1, 0o1)
        }
      }
    end

    let(:invalid_params) do
      { id: user.id, user: { email: nil } }
    end

    context 'when admin login' do
      context 'when params is valid' do
        before do
          sign_in(admin)
          patch :update, params: valid_params

          user.reload
        end

        it 'updates user' do
          expect(user.email).to eq 'test@sample.com'
          expect(user.first_name).to eq 'Foo'
          expect(user.last_name).to eq 'Bar'
          expect(user.birthdate).to eq Date.new(1999, 0o1, 0o1)
        end
      end

      context 'when params is invalid' do
        before do
          sign_in(admin)
          patch :update, params: invalid_params

          user.reload
        end

        it 'does not updates user' do
          expect(user.email).not_to be_nil
        end

        it 'renders edit' do
          expect(response).to render_template('edit')
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
    let!(:user2) { create(:user) }

    context 'when admin login' do
      before do
        sign_in(admin)
        delete :destroy, params: { id: user2.id }
      end

      it 'removes user' do
        expect(User.count).to eq 2
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        delete :destroy, params: { id: user2.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end
end
