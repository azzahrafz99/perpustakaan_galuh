require 'rails_helper'

RSpec.describe TransactionsController do
  let!(:user)        { create(:user) }
  let!(:admin)       { create(:admin) }
  let!(:transaction) { create(:transaction) }

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
    context 'when get transaction' do
      before do
        sign_in(user)
        get :show, params: { id: transaction.id }
      end

      it 'assigns transaction' do
        expect(assigns(:transaction)).to eq transaction
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

      it 'renders new' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'POST create' do
    let(:book) { create(:book, stock: 2) }

    let(:valid_params) do
      {
        transaction: {
          loan_date: Date.current, period: 7,
          user_id: user.id, book_id: book.id
        }
      }
    end

    let(:invalid_params) do
      {
        transaction: {
          loan_date: nil, period: 7,
          user_id: user.id, book_id: book.id
        }
      }
    end

    shared_examples 'creates transaction' do
      let(:last_transaction) { Transaction.last }

      it 'creates transaction' do
        expect(last_transaction.book).to eq book
        expect(last_transaction.user).to eq user
        expect(last_transaction.loan_date).to eq Date.current
        expect(last_transaction.period).to eq 7
      end
    end

    context 'when admin login' do
      before do
        sign_in(admin)
        post :create, params: params

        book.reload
      end

      context 'when params is valid' do
        let(:params) { valid_params }

        it_behaves_like 'creates transaction'

        it 'updates book stock' do
          expect(book.stock).to eq 1
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
        post :create, params: params
      end

      context 'when params is valid' do
        let(:params) { valid_params }

        it_behaves_like 'creates transaction'
      end

      context 'when params is invalid' do
        let(:params) { invalid_params }

        it 'renders new' do
          expect(response).to render_template('new')
        end
      end
    end
  end

  describe 'GET edit' do
    context 'when admin login' do
      before do
        sign_in(admin)

        get :edit, params: { id: transaction.id }
      end

      it 'renders edit' do
        expect(response).to render_template('edit')
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        get :edit, params: { id: transaction.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end

  describe 'PATCH update' do
    let(:book2) { create(:book) }

    let(:valid_params) do
      {
        id: transaction.id,
        transaction: { book_id: book2.id }
      }
    end

    let(:invalid_params) do
      {
        id: transaction.id,
        transaction: { book_id: nil }
      }
    end

    context 'when admin login' do
      before do
        sign_in(admin)
        patch :update, params: params

        transaction.reload
      end

      context 'when params is valid' do
        let(:params) { valid_params }

        it 'updates transaction' do
          expect(transaction.book).to eq book2
        end
      end

      context 'when params is invalid' do
        let(:params) { invalid_params }

        it 'does not updates transaction' do
          expect(transaction.book).not_to be_nil
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
      before do
        sign_in(admin)

        get :destroy, params: { id: transaction.id }
      end

      it 'removes transaction' do
        expect(Transaction.count).to be_zero
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        get :destroy, params: { id: transaction.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end
end
