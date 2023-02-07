require 'rails_helper'

RSpec.describe 'Book' do
  let!(:user)  { create(:user) }
  let!(:admin) { create(:admin) }

  let!(:book) do
    create(:book, isbn: '0889290936097', author: 'Trevor Noah',
                  title: 'Born a Crime: Stories From a South African Childhood',
                  publisher: 'Spiegel & Grau', stock: 1)
  end

  context 'when current user go to books page' do
    before do
      sign_in_user(user)
      visit books_path
    end

    it 'shows books datatable' do
      within('table') do
        expect(page).to have_text '0889290936097'
        expect(page).to have_text 'Born a Crime: Stories From a South African Childhood'
        expect(page).to have_text 'Trevor Noah'
        expect(page).to have_css("#show-book-#{book.id}")
        expect(page).not_to have_css("#edit-book-#{book.id}")
        expect(page).not_to have_css("#delete-book-#{book.id}")
      end
    end

    it 'does not shows link to add new book' do
      expect(page).not_to have_css('#add-new-book')
    end
  end

  context 'when admin go to books page' do
    before do
      sign_in_user(admin)
      visit books_path
    end

    it 'shows books datatable' do
      within('table') do
        expect(page).to have_text '0889290936097'
        expect(page).to have_text 'Born a Crime: Stories From a South African Childhood'
        expect(page).to have_text 'Trevor Noah'
        expect(page).to have_css("#show-book-#{book.id}")
        expect(page).to have_css("#edit-book-#{book.id}")
        expect(page).to have_css("#delete-book-#{book.id}")
      end
    end

    it 'shows link to add new book' do
      expect(page).to have_css('#add-new-book')
    end
  end
end
