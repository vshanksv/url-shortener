require 'rails_helper'

describe 'V1::ShortLink#redirect', type: :feature do
  let!(:short_link) { create(:short_link, target_url: "https://www.wikipedia.org/") }

  it 'redirection' do
    visit short_link.short_url

    expect(page).to have_current_path("https://www.wikipedia.org/")
  end
end
