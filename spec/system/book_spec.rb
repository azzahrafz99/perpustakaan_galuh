require 'rails_helper'

RSpec.describe 'Book' do
  let!(:user)     { create(:user) }
  let!(:admin)    { create(:admin) }
  let!(:category) { create(:category, name: 'Non-Fiction') }

  let!(:book) do
    create(:book, category: category, isbn: '0889290936097', author: 'Trevor Noah',
                  title: 'Born a Crime: Stories From a South African Childhood',
                  publisher: 'Spiegel & Grau', stock: 1)
  end

  let!(:book2) do
    create(:book, isbn: '9781455563920', author: 'Min Jin Lee',
                  title: 'Pachinko', publisher: 'Grand Central Publishing', stock: 1)
  end

  # rubocop:disable RSpec/ExampleLength
  # rubocop:disable RSpec/MultipleExpectations
  context 'when current user go to books page' do
    before { sign_in_user(user) }

    shared_examples 'does not shows link to add new book' do
      it 'does not shows link to add new book' do
        expect(page).not_to have_css('#add-new-book')
      end
    end

    context 'when category is provided' do
      before { visit books_path(category: category.name) }

      it 'shows only Non-Fiction books' do
        within('table > tbody') do
          expect(all('tr').count).to eq 1

          within(all('tr')[0]) do
            expect(page).to have_text '0889290936097'
            expect(page).to have_text 'Born a Crime: Stories From a South African Childhood'
            expect(page).to have_text 'Trevor Noah'
            expect(page).to have_css("#show-book-#{book.id}")
            expect(page).not_to have_css("#edit-book-#{book.id}")
            expect(page).not_to have_css("#delete-book-#{book.id}")
          end

          expect(page).not_to have_text '9781455563920'
          expect(page).not_to have_text 'Pachinko'
          expect(page).not_to have_text 'Min Jin Lee'
          expect(page).not_to have_css("#show-book-#{book2.id}")
          expect(page).not_to have_css("#edit-book-#{book2.id}")
          expect(page).not_to have_css("#delete-book-#{book2.id}")
        end
      end

      it_behaves_like 'does not shows link to add new book'
    end

    context 'when category is not provided' do
      before { visit books_path }

      it 'shows all books' do
        within('table > tbody') do
          expect(all('tr').count).to eq 2

          within(all('tr')[0]) do
            expect(page).to have_text '0889290936097'
            expect(page).to have_text 'Born a Crime: Stories From a South African Childhood'
            expect(page).to have_text 'Trevor Noah'
            expect(page).to have_css("#show-book-#{book.id}")
            expect(page).not_to have_css("#edit-book-#{book.id}")
            expect(page).not_to have_css("#delete-book-#{book.id}")
          end

          within(all('tr')[1]) do
            expect(page).to have_text '9781455563920'
            expect(page).to have_text 'Pachinko'
            expect(page).to have_text 'Min Jin Lee'
            expect(page).to have_css("#show-book-#{book2.id}")
            expect(page).not_to have_css("#edit-book-#{book2.id}")
            expect(page).not_to have_css("#delete-book-#{book2.id}")
          end
        end
      end

      it_behaves_like 'does not shows link to add new book'
    end
  end

  context 'when admin go to books page' do
    before do
      sign_in_user(admin)
      visit books_path
    end

    it 'shows books datatable' do
      within('table > tbody') do
        within(all('tr')[0]) do
          expect(page).to have_text '0889290936097'
          expect(page).to have_text 'Born a Crime: Stories From a South African Childhood'
          expect(page).to have_text 'Trevor Noah'
          expect(page).to have_css("#show-book-#{book.id}")
          expect(page).to have_css("#edit-book-#{book.id}")
          expect(page).to have_css("#delete-book-#{book.id}")
        end

        within(all('tr')[1]) do
          expect(page).to have_text '9781455563920'
          expect(page).to have_text 'Pachinko'
          expect(page).to have_text 'Min Jin Lee'
          expect(page).to have_css("#show-book-#{book2.id}")
          expect(page).to have_css("#edit-book-#{book2.id}")
          expect(page).to have_css("#delete-book-#{book2.id}")
        end
      end
    end

    it 'shows link to add new book' do
      expect(page).to have_css('#add-new-book')
    end
  end
  # rubocop:enable RSpec/ExampleLength
  # rubocop:enable RSpec/MultipleExpectations
end
