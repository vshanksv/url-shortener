require 'rails_helper'

describe ImpressionReportService do
  let(:search) { OpenStruct.new(start_date: 3.months.ago, end_date: DateTime.now) }
  let(:other_user) { create(:user, :consumer) }

  before do
    allow(Current).to receive(:user).and_return(user)
  end

  context 'when user is admin' do
    let(:user) { create(:user, :admin) }

    before do
      create(:short_link_fact, :with_short_link, created_at: 1.month.ago, user_id: other_user.id)
      create(:short_link_fact, :with_short_link, created_at: 2.months.ago, user_id: user.id)
      create(:short_link_fact, :with_short_link, created_at: 2.months.ago, user_id: user.id)
      create(:short_link_fact, :with_short_link, created_at: 4.months.ago, user_id: user.id)
    end

    it 'return all short link within the date range' do
      response = described_class.call(search)

      expect(response).to be_success
      expect(response.response.keys.size).to eq(3)
    end
  end

  context 'when user is not admin' do
    let(:user) { create(:user, :consumer) }
    let(:admin_user) { create(:user, :admin) }

    before do
      create(:short_link_fact, :with_short_link, created_at: 1.month.ago, user_id: other_user.id)
      create(:short_link_fact, :with_short_link, created_at: 2.months.ago, user_id: admin_user.id)
      create(:short_link_fact, :with_short_link, created_at: 2.months.ago, user_id: user.id)
      create(:short_link_fact, :with_short_link, created_at: 4.months.ago, user_id: user.id)
    end

    it 'return the short link created within the date range by the user only' do
      response = described_class.call(search)

      expect(response).to be_success
      expect(response.response.keys.size).to eq(1)
    end
  end
end
