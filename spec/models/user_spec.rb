require 'rails_helper'

RSpec.describe User do
  describe 'Associations' do
    it { is_expected.to have_many(:transactions) }
  end

  describe 'Validations' do
    let(:user) do
      create(:user, email: 'test@sample.com', password: 'password123',
                    password_confirmation: 'password123')
    end

    it 'is database authenticable' do
      expect(user).to be_valid_password('password123')
    end
  end

  describe '#assign_default_role' do
    let!(:user) { create(:user) }

    it 'assigns role user' do
      expect(user).to have_role(:user)
    end
  end
end
