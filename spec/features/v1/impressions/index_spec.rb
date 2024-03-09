require 'rails_helper'

describe 'V1::Impressions#index', type: :feature do
  let(:user) { create(:user) }

  context 'when unauthorized' do
    it 'show unauthorized message' do
      visit v1_impressions_path

      expect(page).to have_content("Unauthorized")
    end
  end

  context 'when authorized' do
    before do
      sign_in(user)
    end

    context 'when there are no impressions' do
      it 'show empty table message' do
        visit v1_impressions_path

        expect(page).to have_content("The table is currently empty")
      end
    end

    context 'when there are impressions' do
      let!(:short_link_fact) { create(:short_link_fact, :with_short_link, user_id: user.id) }

      it 'show the data' do
        visit v1_impressions_path

        expect(page).to have_content(short_link_fact.short_url)
      end
    end
  end
end
