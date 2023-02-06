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
  end
end
