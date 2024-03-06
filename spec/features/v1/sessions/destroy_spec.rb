require 'rails_helper'

describe 'V1::Sessions#destroy', type: :feature do
  let!(:user) { create(:user) }

  before do
    sign_in(user)
  end

  it 'logouts' do
    click_on 'Sign Out'

    expect(page).to have_content('Sign In')
  end
end
