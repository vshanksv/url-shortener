require 'rails_helper'

RSpec.describe ShortLinkFactDecorator do
  let!(:short_link_fact) { create(:short_link_fact, :with_short_link) }

  describe '#location' do
    it 'returns the location' do
      decorated = short_link_fact.decorate

      expect(decorated.location).to be_present
    end
  end

  describe '#created_at' do
    it 'returns the created_at' do
      decorated = short_link_fact.decorate

      expect(decorated.created_at).to eq(short_link_fact.created_at.strftime("%Y-%m-%d %H:%M:%S"))
    end
  end
end
