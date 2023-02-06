require 'rails_helper'

RSpec.describe Book do
  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:book_code) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:publisher) }
    it { is_expected.to validate_uniqueness_of(:book_code) }
  end
end
