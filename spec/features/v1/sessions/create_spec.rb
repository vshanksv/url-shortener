require 'rails_helper'

describe 'V1::Sessions#create', type: :feature do
  let!(:user) { create(:user) }

  before do
    visit new_v1_session_path
  end

  it 'logins' do
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_on 'Sign in'

    expect(page).to have_content('Sign Out')
  end

  it 'does not login' do
    fill_in 'email', with: user.email
    fill_in 'password', with: 'wrong password'

    click_on 'Sign in'

    expect(page).to have_content('Invalid email or password')
  end
end
