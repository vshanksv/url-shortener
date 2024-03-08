require 'rails_helper'

RSpec.describe ImpressionJob, type: :job do
  let!(:short_link) { create(:short_link) }

  context 'when ip is invalid' do
    it 'fails to create the short link fact' do
      expect { described_class.new.perform('XXX', short_link.short_url) }.to raise_error(ActiveRecord::RecordInvalid)
      expect(ShortLinkFact.count).to eq(0)
    end
  end

  context 'when ip is valid' do
    it 'creates the short link fact' do
      described_class.new.perform(Faker::Internet.ip_v4_address, short_link.short_url)
      expect(ShortLinkFact.count).to eq(1)
    end
  end
end
