module TestingSupport
  module SystemHelper
    def sign_up_user
      visit new_user_registration_path
      fill_in 'user_email', with: 'test@sample.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_on 'sign-up-submit'
    end

    def sign_up_with_existing_user(user)
      visit new_user_registration_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_on 'sign-up-submit'
    end

    def sign_up_with_unmatched_password
      visit new_user_registration_path
      fill_in 'user_email', with: 'test@sample.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password123'
      click_on 'sign-up-submit'
    end

    def sign_in_user(user)
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      click_on 'sign-in-submit'
    end

    def change_password_success(user)
      visit edit_user_registration_path(user)
      fill_in 'user_password', with: 'new_password'
      fill_in 'user_password_confirmation', with: 'new_password'
      fill_in 'user_current_password', with: 'password'
      click_on 'Update'
    end

    def change_password_failed(user)
      visit edit_user_registration_path(user)
      fill_in 'user_password', with: 'new_password'
      fill_in 'user_password_confirmation', with: 'new_password'
      fill_in 'user_current_password', with: 'passwords'
      click_on 'Update'
    end
  end
end

RSpec.configure do |config|
  config.include TestingSupport::SystemHelper, type: :system
end
