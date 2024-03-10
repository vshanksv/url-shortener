require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_user_header(user) }
  let(:target_url) { 'www.example.com' }
  let(:params) { { target_url: } }

  describe 'POST /api/v1/url/shorten' do
    before { post '/api/v1/url/shorten', params:, headers: }

    context 'when target_url is valid' do
      it 'returns success response and create short link' do
        expect(response.status).to eq 201
        expect(json).to include('short_url', 'target_url')
      end
    end

    context 'when target_url is invalid' do
      let(:target_url) { 'example' }

      it 'returns unprocessable_entity response' do
        expect(response.status).to eq 422
        expect(json).to include('error_message', 'error_type')
      end
    end

    context 'when target_url is missing' do
      let(:params) { {} }

      it 'returns unprocessable_entity response' do
        expect(response.status).to eq 422
        expect(json).to include('error_message', 'error_type')
      end
    end
  end
end
