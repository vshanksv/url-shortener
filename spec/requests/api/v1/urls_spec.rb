require 'swagger_helper'

RSpec.describe 'api/v1/urls', type: :request do
  let(:user) { create(:user) }
  let(:access_token) { JwtHelper.encode({ user_id: user.id }) }
  let(:Authorization) { "Bearer #{access_token}" }
  let(:url) { { target_url: 'https://www.google.com' } }

  path '/api/v1/url/shorten' do
    post('create url') do
      tags 'URL Shortener'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :url, in: :body, schema: {
        type: :object,
        properties: {
          target_url: { type: :string }
        },
        required: ['target_url']
      }

      response(201, 'successful') do
        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data).to include(:target_url, :short_url)
        end
      end
    end
  end
end
