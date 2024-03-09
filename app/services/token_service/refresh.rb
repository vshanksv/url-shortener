module TokenService
  class Refresh
    include BaseService

    attr_reader :refresh_token

    def initialize(refresh_token)
      @refresh_token = refresh_token
    end

    def call
      payload = JwtHelper.decode(refresh_token).first
      user = User.find_by(id: payload["user_id"])
      return failure({ error_message: "Invalid refresh token", error_type: "invalid_refresh_token" }) if user.blank?

      access_token = JwtHelper.encode({ user_id: user.id })
      success({ access_token: })
    rescue JWT::ExpiredSignature => e
      Rails.logger.error "JWT::ExpiredSignature: #{e.message}"
      failure({ error_message: e.message, error_type: "refresh_token_expired" })
    rescue StandardError => e
      Rails.logger.error "StandardError: #{e.message}"
      failure({ error_message: 'Invalid refresh token', error_type: "invalid_refresh_token" })
    end
  end
end
