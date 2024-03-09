require 'rails_helper'

RSpec.describe TokenService::Refresh do
  let(:user) { create(:user) }

  context 'when refresh token is valid/found' do
    let(:refresh_token) { JwtHelper.encode({ user_id: user.id }) }

    it 'returns success' do
      result = described_class.call(refresh_token)

      expect(result).to be_success
      expect(result.response).to include(:access_token)
    end
  end

  context 'when refresh token is invalid' do
    it 'returns failure' do
      result = described_class.call('invalid_api_key')

      expect(result).not_to be_success
      expect(result.response).to include(error_message: "Invalid refresh token", error_type: "invalid_refresh_token")
    end
  end

  context 'when refresh token is expired' do
    let(:refresh_token) { JwtHelper.encode({ user_id: user.id }, 1.day.ago.to_i) }

    it 'returns failure' do
      result = described_class.call(refresh_token)

      expect(result).not_to be_success
      expect(result.response).to include(error_message: "Signature has expired", error_type: "refresh_token_expired")
    end
  end
end
