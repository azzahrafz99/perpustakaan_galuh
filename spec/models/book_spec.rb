require 'rails_helper'

RSpec.describe Book do
  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:transactions) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:publisher) }
    it { is_expected.to validate_uniqueness_of(:isbn) }
  end

  describe 'methods' do
    let!(:book)  { create(:book, stock: 0) }
    let!(:book2) { create(:book, stock: 1) }

    describe '#available' do
      it 'returns only books that only have stock greater than 0' do
        expect(described_class.available).to eq [book2]
      end
    end

    describe '#available?' do
      it 'returns false when book stock is 0' do
        expect(book).not_to be_available
      end

      it 'returns true when book stock is greater than 0' do
        expect(book2).to be_available
      end
    end
  end
end
