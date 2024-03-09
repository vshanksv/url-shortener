FactoryBot.define do
  factory :user_api_key do
    user { nil }
    api_key do
      key = SecureRandom.random_bytes(32)
      Base64.strict_encode64(key)
    end
  end
end
