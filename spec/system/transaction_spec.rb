require 'rails_helper'

RSpec.describe 'Transaction' do
  let!(:user)  { create(:user) }
  let!(:admin) { create(:admin) }

  context 'when user go to transactions page' do
    let!(:user2) { create(:user, email: 'user2@sample.com') }

    let!(:book) do
      create(:book, isbn: '9780241334140', title: 'Becoming')
    end

    let!(:book2) do
      create(:book, isbn: '9780399590504', title: 'Educated')
    end

    let!(:transaction)  { create(:transaction, book: book, user: user) }

    let!(:transaction2) do
      create(:transaction, book: book2, user: user2, loan_date: Date.current - 7.days, period: 5)
    end

    let!(:transaction3) do
      create(:transaction, book: book2, user: user,
                           loan_date: Date.current - 7.days, period: 5,
                           return_date: Date.current)
    end

    # rubocop:disable RSpec/ExampleLength
    # rubocop:disable RSpec/MultipleExpectations
    context 'when current user go to transactions page' do
      before do
        sign_in_user(user)
        visit transactions_path
      end

      it 'only shows transactions from current_user' do
        within('table > tbody') do
          within(all('tr')[0]) do
            expect(page).to have_text '9780241334140'
            expect(page).to have_text 'Becoming'
            expect(page).to have_text 'on going'

            expect(page).to have_css("#show-transaction-#{transaction.id}")
            expect(page).not_to have_css("#edit-transaction-#{transaction.id}")
            expect(page).not_to have_css("#delete-transaction-#{transaction.id}")
          end

          within(all('tr')[1]) do
            expect(page).to have_text '9780399590504'
            expect(page).to have_text 'Educated'
            expect(page).to have_text 'done'

            expect(page).to have_css("#show-transaction-#{transaction3.id}")
            expect(page).not_to have_css("#edit-transaction-#{transaction3.id}")
            expect(page).not_to have_css("#delete-transaction-#{transaction3.id}")
          end
        end
      end

      it 'does not shows link to add new transaction' do
        expect(page).not_to have_css('#add-new-transaction')
      end
    end

    context 'when admin go to transactions page' do
      before do
        sign_in_user(admin)
        visit transactions_path
      end

      it 'only shows all transactions' do
        within('table > tbody') do
          within(all('tr')[0]) do
            expect(page).to have_text '9780241334140'
            expect(page).to have_text 'Becoming'
            expect(page).to have_text 'on going'

            expect(page).to have_css("#show-transaction-#{transaction.id}")
            expect(page).to have_css("#edit-transaction-#{transaction.id}")
            expect(page).to have_css("#delete-transaction-#{transaction.id}")
          end

          within(all('tr')[1]) do
            expect(page).to have_text '9780399590504'
            expect(page).to have_text 'Educated'
            expect(page).to have_text 'delayed'

            expect(page).to have_css("#show-transaction-#{transaction2.id}")
            expect(page).to have_css("#edit-transaction-#{transaction2.id}")
            expect(page).to have_css("#delete-transaction-#{transaction2.id}")
          end

          within(all('tr')[2]) do
            expect(page).to have_text '9780399590504'
            expect(page).to have_text 'Educated'
            expect(page).to have_text 'done'

            expect(page).to have_css("#show-transaction-#{transaction3.id}")
            expect(page).to have_css("#edit-transaction-#{transaction3.id}")
            expect(page).to have_css("#delete-transaction-#{transaction3.id}")
          end
        end
      end

      it 'shows link to add new transaction' do
        expect(page).to have_css('#add-new-transaction')
      end
    end
    # rubocop:enable RSpec/ExampleLength
    # rubocop:enable RSpec/MultipleExpectations
  end
end
