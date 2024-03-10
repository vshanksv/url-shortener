require 'rails_helper'

describe RateLimitingService do
  before do
    allow(Current).to receive(:user).and_return(user)
  end

  context 'when anonymous user' do
    let(:user) { nil }

    it 'succeeds' do
      3.times do
        response = described_class.call(1.minute, 1.minute, 1)
        expect(response).to be_success
      end
    end
  end

  context 'when admin user is logged in' do
    let(:user) { create(:user, :admin) }

    it 'succeeds' do
      3.times do
        response = described_class.call(1.minute, 1.minute, 1)
        expect(response).to be_success
      end
    end
  end

  context 'when user is logged in' do
    let(:user) { create(:user, :consumer) }

    context 'when rate limit is not exceeded' do
      it 'succeeds' do
        response = described_class.call(1.minute, 1.minute, 1)

        expect(response).to be_success
      end
    end

    context 'when rate limit is exceeded' do
      it 'failure' do
        3.times do |index|
          response = described_class.call(1.minute, 1.minute, 1)
          if index == 0
            expect(response).to be_success
          else
            expect(response).not_to be_success
          end
        end
      end
    end
  end
end
