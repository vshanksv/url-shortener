require 'rails_helper'

describe ShortenUrlService do
  let!(:existing_short_link) { create(:short_link) }
  let(:short_link) { build(:short_link) }

  context 'when short_url is duplicated' do
    it 'failure' do
      allow(SecureRandom).to receive(:urlsafe_base64).and_return(existing_short_link.short_url)
      response = described_class.call(short_link)

      expect(response).not_to be_success
    end
  end

  context 'when short link is valid' do
    it 'succeeds' do
      response = described_class.call(short_link)

      expect(response).to be_success
      expect(ShortLink.count).to eq(2)
    end
  end
end
