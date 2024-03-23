require 'rails_helper'

describe 'V1::UserApiKeys#index', type: :feature do
  let(:user) { create(:user) }

  context 'when unauthorized' do
    it 'show unauthorized message' do
      visit v1_user_api_keys_path

      expect(page).to have_content("Unauthorized")
    end
  end

  context 'when authorized' do
    before do
      sign_in(user)
    end

    it 'create api key when click on generate button' do
      visit v1_user_api_keys_path

      expect do
        click_on "Generate"
      end.to change(UserApiKey, :count).by(1)

      expect(page).to have_content("Generate")
    end
  end
end
