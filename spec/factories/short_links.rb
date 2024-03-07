FactoryBot.define do
  factory :short_link do
    target_url { Faker::Internet.url }
    short_url { SecureRandom.urlsafe_base64(6) }
    title { "Random title" }
    user { nil }
  end
end
