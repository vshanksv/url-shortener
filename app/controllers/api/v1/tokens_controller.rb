module Api
  module V1
    class TokensController < Api::V1::ApplicationController
      # - Before making a request, check the expiry time of the token
      # - If close to expire (~3m threshold), initiate refresh, and then proceed with original request
      # - If the refresh token is expired as well, initiate new access token

      def create
        result = TokenService::Create.call(params[:api_key])

        if result.success?
          render json: result.response, status: :ok
        else
          render json: result.response, status: :unauthorized
        end
      end

      def refresh
        result = TokenService::Refresh.call(params[:refresh_token])

        if result.success?
          render json: result.response, status: :ok
        else
          render json: result.response, status: :unauthorized
        end
      end
    end
  end
end
