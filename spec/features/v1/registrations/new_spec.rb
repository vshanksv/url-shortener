require 'rails_helper'

describe 'V1::Registrations#new', type: :feature do
  before do
    visit new_v1_registration_path
  end

  it 'registration form' do
    expect(page).to have_button('Create an account')
  end
end
