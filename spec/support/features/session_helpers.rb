module Features
  module SessionHelpers
    def sign_in(user = nil)
      user ||= create(:user)
      visit new_v1_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'

      click_button 'Login'

      user
    end
  end
end
