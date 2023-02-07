require 'rails_helper'

RSpec.describe BooksController do
  let!(:user)  { create(:user) }
  let!(:admin) { create(:admin) }

  let!(:book) do
    create(:book, isbn: '0889290936097', author: 'Trevor Noah',
                  title: 'Born a Crime: Stories From a South African Childhood',
                  publisher: 'Spiegel & Grau')
  end

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
    context 'when get book' do
      before do
        sign_in(user)
        get :show, params: { id: book.id }
      end

      it 'assigns book' do
        expect(assigns(:book)).to eq book
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
    let(:category) { create(:category, name: 'Non-Fiction') }

    let(:valid_params) do
      {
        book: {
          isbn: '9780399590504', title: 'Educated',
          author: 'Tara Westover', publisher: 'Random House',
          category_id: category.id
        }
      }
    end

    let(:invalid_params) do
      {
        book: {
          isbn: nil, title: 'Educated',
          author: 'Tara Westover', publisher: 'Random House',
          category_id: category.id
        }
      }
    end

    context 'when admin login' do
      before do
        sign_in(admin)
        post :create, params: params
      end

      context 'when params is valid' do
        let(:params)    { valid_params }
        let(:last_book) { Book.last }

        it 'creates book' do
          expect(last_book.isbn).to eq '9780399590504'
          expect(last_book.title).to eq 'Educated'
          expect(last_book.publisher).to eq 'Random House'
          expect(last_book.category).to eq category
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

        get :edit, params: { id: book.id }
      end

      it 'renders edit' do
        expect(response).to render_template('edit')
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        get :edit, params: { id: book.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end

  describe 'PATCH update' do
    let(:valid_params) do
      {
        id: book.id,
        book: {
          isbn: '9780399590504', title: 'Educated',
          author: 'Tara Westover', publisher: 'Random House'
        }
      }
    end

    let(:invalid_params) do
      {
        id: book.id,
        book: { isbn: nil }
      }
    end

    context 'when admin login' do
      before do
        sign_in(admin)
        patch :update, params: params

        book.reload
      end

      context 'when params is valid' do
        let(:params) { valid_params }

        it 'updates book' do
          expect(book.isbn).to eq '9780399590504'
          expect(book.title).to eq 'Educated'
          expect(book.publisher).to eq 'Random House'
          expect(book.author).to eq 'Tara Westover'
        end
      end

      context 'when params is invalid' do
        let(:params) { invalid_params }

        it 'does not updates book' do
          expect(book.isbn).to eq '0889290936097'
          expect(book.title).to eq 'Born a Crime: Stories From a South African Childhood'
          expect(book.publisher).to eq 'Spiegel & Grau'
          expect(book.author).to eq 'Trevor Noah'
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

        get :destroy, params: { id: book.id }
      end

      it 'removes book' do
        expect(Book.count).to be_zero
      end
    end

    context 'when user login' do
      before do
        sign_in(user)

        get :destroy, params: { id: book.id }
      end

      it_behaves_like 'redirect to dashboard with error message'
    end
  end
end
