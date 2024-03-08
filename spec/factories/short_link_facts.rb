FactoryBot.define do
  factory :short_link_fact do
    short_url { SecureRandom.urlsafe_base64(6) }
    ip { Faker::Internet.ip_v4_address }
    user { nil }
  end
end
