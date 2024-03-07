require 'rails_helper'

describe 'V1::ShortLinks#show', type: :feature do
  let!(:short_link) { create(:short_link) }

  before do
    visit v1_short_link_path(short_link)
  end

  it 'show original and shortened url' do
    expect(page).to have_content("Original URL\nShortened URL\n")
  end
end
