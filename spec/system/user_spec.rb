require 'rails_helper'

RSpec.describe 'User' do
  let!(:user)         { create(:user) }
  let!(:invalid_user) { build(:user, email: 'tes@sample.com', password: 'password') }

  context 'when user sign up' do
    context 'when user sign up successfully' do
      before { sign_up_user }

      it 'returns message' do
        expect(page).to have_text('Welcome! You have signed up successfully.')
      end
    end

    context 'when user failed to sign up because email has been taken' do
      before { sign_up_with_existing_user(user) }

      it 'returns message' do
        expect(page).to have_text('Email has already been taken')
      end
    end

    context 'when user failed to sign up because password did not match' do
      before { sign_up_with_unmatched_password }

      it 'returns message' do
        expect(page).to have_text("Password confirmation doesn't match Password")
      end
    end
  end

  context 'when user sign in' do
    it 'when user sign in successfully' do
      sign_in_user(user)
      expect(page).to have_text('Signed in successfully.')
    end

    it 'when user failed to sign in' do
      sign_in_user(invalid_user)
      expect(page).to have_text('Invalid Email or password.')
    end
  end

  context 'when user change password' do
    before { sign_in_user(user) }

    it 'when user change password successfully' do
      change_password_success(user)

      expect(page).to have_text('Your account has been updated successfully.')
    end

    it 'when user failed to change password' do
      change_password_failed(user)

      expect(page).to have_text('error prohibited this user from being saved')
    end
  end
end
