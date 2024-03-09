require 'rails_helper'

RSpec.describe TokenService::Create do
  let(:user) { create(:user) }
  let(:user_api_key) { create(:user_api_key, user:) }

  context 'when api_key is valid/found' do
    it 'returns success' do
      result = described_class.call(user_api_key.api_key)

      expect(result).to be_success
      expect(result.response).to include(:access_token, :refresh_token, :expires_in, :refresh_expires_in)
    end
  end

  context 'when api_key is invalid/not found' do
    it 'returns failure' do
      result = described_class.call('invalid_api_key')

      expect(result).not_to be_success
      expect(result.response).to include(error_message: "Invalid API Key", error_type: "invalid_api_key")
    end
  end
end
