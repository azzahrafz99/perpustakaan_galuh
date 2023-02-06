require 'rails_helper'

RSpec.describe Transaction do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:borrow_date) }
    it { is_expected.to validate_presence_of(:return_date) }
    it { is_expected.to validate_presence_of(:period) }

    describe '#return_date_is_after_borrow_date' do
      context 'when return_date is after borrow_date' do
        let!(:transaction) do
          build :transaction, borrow_date: Date.new(2023, 01, 01),
                              return_date: Date.new(2023, 01, 05),
                              period: 7
        end

        it 'returns true' do
          expect(transaction.valid?).to be_truthy
        end
      end

      context 'when return_date is after borrow_date' do
        let(:transaction) do
          build :transaction, borrow_date: Date.new(2023, 01, 03),
                              return_date: Date.new(2023, 01, 01),
                              period: 7
        end

        it 'returns false' do
          expect(transaction.valid?).to be_falsey
        end
      end
    end
  end
end
