module Api
  module V1
    class ApplicationController < ActionController::API
      def current_user
        if request.headers['Authorization'].blank?
          return render json: { error_message: "Access token is not found", error_type: "invalid_token" },
                        status: :unauthorized
        end

        user_id = JwtHelper.decode(request.headers['Authorization'].split.last).first["user_id"]
        Current.user ||= User.find_by(id: user_id)
      rescue StandardError => e
        Rails.logger.error "Failed to find user. #{e.message}"
        render json: { error_message: e.message, error_type: e.class.name }, status: :unauthorized
      end

      def authorize_user!
        return if current_user.present?

        render json: { error_message: e.message, error_type: e.class.name },
               status: :unauthorized
      end
    end
  end
end
