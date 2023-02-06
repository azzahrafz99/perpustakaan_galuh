require 'rails_helper'

RSpec.describe Transaction do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:loan_date) }
    it { is_expected.to validate_presence_of(:period) }

    describe '#return_date_is_after_loan_date' do
      context 'when return_date is after loan_date' do
        let!(:transaction) do
          build(:transaction, loan_date: Date.new(2023, 0o1, 0o1),
                              return_date: Date.new(2023, 0o1, 0o5),
                              period: 7)
        end

        it 'returns true' do
          expect(transaction).to be_valid
        end
      end

      context 'when return_date is before loan_date' do
        let(:transaction) do
          build(:transaction, loan_date: Date.new(2023, 0o1, 0o3),
                              return_date: Date.new(2023, 0o1, 0o1),
                              period: 7)
        end

        it 'returns false' do
          expect(transaction).not_to be_valid
        end
      end
    end
  end

  describe '#status' do
    let(:today) { DateTime.parse('2023-01-10') }

    before { Timecop.freeze(today) }
    after  { Timecop.return }

    context "when book hasn't been returned after the period ends" do
      let!(:transaction) do
        create(:transaction, loan_date: Date.new(2023, 0o1, 0o1),
                             period: 7)
      end

      it 'returns delayed' do
        expect(transaction.status).to eq 'delayed'
      end
    end

    context 'when the period is still on going' do
      let!(:transaction) do
        create(:transaction, loan_date: Date.new(2023, 0o1, 0o1),
                             period: 12)
      end

      it 'returns delayed' do
        expect(transaction.status).to eq 'on going'
      end
    end

    context 'when book has been returned' do
      let!(:transaction) do
        create(:transaction, loan_date: Date.new(2023, 0o1, 0o1),
                             return_date: Date.new(2023, 0o1, 0o7),
                             period: 7)
      end

      it 'returns delayed' do
        expect(transaction.status).to eq 'done'
      end
    end
  end
end
