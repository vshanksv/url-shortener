require 'rails_helper'

describe 'V1::Sessions#new', type: :feature do
  before do
    visit new_v1_session_path
  end

  it 'login form' do
    expect(page).to have_button('Sign in')
  end
end
