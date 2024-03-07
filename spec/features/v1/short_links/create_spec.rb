require 'rails_helper'

describe 'V1::ShortLinks#create', type: :feature do
  before do
    visit new_v1_short_link_path
  end

  context 'when short link is valid' do
    it 'create new short link' do
      fill_in 'short_link_target_url', with: Faker::Internet.url

      click_on 'Shorten URL'

      expect(page).to have_content('Shorten another')
    end
  end

  context 'when short_url is duplicated' do
    it 'no short link is created' do
      allow(ShortenUrlService).to receive(:call)
        .and_return(OpenStruct.new(success?: false, response: 'Short URL is duplicated'))
      fill_in 'short_link_target_url', with: Faker::Internet.url

      click_on 'Shorten URL'

      expect(page).to have_content('Short URL is duplicated')
    end
  end
end
