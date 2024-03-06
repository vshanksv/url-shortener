require 'rails_helper'

describe 'V1::Registrations#create', type: :feature do
  before do
    visit new_v1_registration_path
  end

  it 'registers successfully' do
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'

    click_on 'Register'

    expect(page).to have_content('Sign Out')
    expect(User.count).to eq(1)
  end

  it 'registers unsuccessfully' do
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'wrong password'

    click_on 'Register'

    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(User.count).to eq(0)
  end
end
