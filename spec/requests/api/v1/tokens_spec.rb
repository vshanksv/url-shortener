require 'swagger_helper'

RSpec.describe 'api/v1/tokens', type: :request do
  let(:user) { create(:user) }
  let(:user_api_key) { create(:user_api_key, user:) }

  path '/api/v1/token/access' do
    let(:token) { { api_key: user_api_key.api_key } }

    post('create token') do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :token, in: :body, schema: {
        type: :object,
        properties: {
          api_key: { type: :string }
        },
        required: ['api_key']
      }

      response(200, 'successful') do
        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data).to include(:access_token, :refresh_token)
        end
      end
    end
  end

  path '/api/v1/token/refresh' do
    let(:token) { { refresh_token: JwtHelper.encode({ user_id: user_api_key.user_id }, 1.week.from_now.to_i) } }

    post('refresh token') do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :token, in: :body, schema: {
        type: :object,
        properties: {
          refresh_token: { type: :string }
        },
        required: ['refresh_token']
      }

      response(200, 'successful') do
        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data).to include(:access_token)
        end
      end
    end
  end
end
