require 'rails_helper'

describe 'V1::Registrations#create', type: :feature do
  before do
    visit new_v1_registration_path
  end

  it 'registers successfully' do
    fill_in 'user_email', with: Faker::Internet.email
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    click_on 'Create an account'

    expect(User.count).to eq(1)
  end

  it 'registers unsuccessfully' do
    fill_in 'user_email', with: Faker::Internet.email
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'wrong password'

    click_on 'Create an account'

    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(User.count).to eq(0)
  end
end
