require 'rails_helper'

describe 'V1::ShortLinks#new', type: :feature do
  before do
    visit new_v1_short_link_path
  end

  it 'shorten url form' do
    expect(page).to have_button('Shorten URL')
  end
end
