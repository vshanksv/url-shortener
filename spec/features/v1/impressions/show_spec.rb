require 'rails_helper'

describe 'V1::Impressions#show', type: :feature do
  let(:user) { create(:user) }
  let!(:short_link_fact) { create(:short_link_fact, :with_short_link, user_id: user.id) }

  context 'when unauthorized' do
    it 'show unauthorized message' do
      visit v1_impression_path(short_link_fact.short_url)

      expect(page).to have_content("Unauthorized")
    end
  end

  context 'when authorized' do
    before do
      sign_in(user)
    end

    it 'show the data' do
      visit v1_impression_path(short_link_fact.short_url)

      expect(page).to have_content(short_link_fact.decorate.created_at)
    end
  end
end
