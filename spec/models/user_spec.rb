require 'rails_helper'

RSpec.describe User do
  describe 'Validations' do
    let(:user) do
      create(:user, email: 'test@sample.com', password: 'password123',
                    password_confirmation: 'password123')
    end

    it 'is database authenticable' do
      expect(user).to be_valid_password('password123')
    end
  end
end
