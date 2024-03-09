module TokenService
  class Create
    include BaseService

    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def call
      user_api_key = UserApiKey.find_by(api_key:)
      return failure({ error_message: "Invalid API Key", error_type: "invalid_api_key" }) if user_api_key.blank?

      access_token = JwtHelper.encode({ user_id: user_api_key.user_id })
      refresh_token = JwtHelper.encode({ user_id: user_api_key.user_id }, 1.week.from_now.to_i)
      success({ access_token:, refresh_token:,
                expires_in: 1.day.from_now.to_i,
                refresh_expires_in: 1.week.from_now.to_i })
    end
  end
end
