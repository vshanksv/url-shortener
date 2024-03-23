module Features
  module SessionHelpers
    def sign_in(user = nil)
      user ||= create(:user)
      visit new_v1_session_path

      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'

      click_button 'Sign in'

      user
    end
  end
end
