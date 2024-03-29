module Api
  module V1
    class UrlsController < Api::V1::ApplicationController
      before_action :authorize_user!
      before_action :prepend_http_if_needed, only: :create

      def create
        short_link = ShortLink.new(target_url: params[:target_url])
        result = ShortenUrlService.call(short_link)

        if result.success?
          render json: UrlPairPresenter.new(result.response).massage_data, status: :created
        else
          render json: { error_message: result.response, error_type: 'invalid' }, status: :unprocessable_entity
        end
      end

      private

      def prepend_http_if_needed
        if params[:target_url].blank?
          return render json: { error_message: 'target_url is required', error_type: 'invalid' },
                        status: :unprocessable_entity
        end

        params[:target_url] = "https://#{params[:target_url]}" unless params[:target_url].start_with?('http://', 'https://')
      end
    end
  end
end
