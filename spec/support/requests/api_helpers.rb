module Requests
  module ApiHelpers
    def auth_user_header(user)
      { 'Authorization' => JwtHelper.encode(user_id: user&.id) }
    end

    def json
      JSON.parse(response.body)
    end
  end
end
