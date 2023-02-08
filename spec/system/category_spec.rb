require 'rails_helper'

RSpec.describe 'Category' do
  let!(:user)     { create(:user) }
  let!(:admin)    { create(:admin) }
  let!(:category) { create(:category, name: 'Non-Fiction') }

  context 'when current user go to categories page' do
    before do
      sign_in_user(user)
      visit categories_path
    end

    it 'shows categories' do
      within('table > tbody') do
        expect(all('tr').count).to eq 1

        within(all('tr')[0]) do
          expect(page).to have_text 'Non-Fiction'
          expect(page).to have_css("#show-category-#{category.id}")
          expect(page).not_to have_css("#edit-category-#{category.id}")
          expect(page).not_to have_css("#delete-category-#{category.id}")
        end
      end
    end

    it 'does not shows link to add new category' do
      expect(page).not_to have_css('#add-new-category')
    end
  end

  context 'when admin go to categories page' do
    before do
      sign_in_user(admin)
      visit categories_path
    end

    it 'shows categories' do
      within('table > tbody') do
        expect(all('tr').count).to eq 1

        within(all('tr')[0]) do
          expect(page).to have_text 'Non-Fiction'
          expect(page).to have_css("#show-category-#{category.id}")
          expect(page).to have_css("#edit-category-#{category.id}")
          expect(page).to have_css("#delete-category-#{category.id}")
        end
      end
    end

    it 'does not shows link to add new category' do
      expect(page).to have_css('#add-new-category')
    end
  end
end
