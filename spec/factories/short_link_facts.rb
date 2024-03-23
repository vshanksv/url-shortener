FactoryBot.define do
  factory :short_link_fact do
    ip { Faker::Internet.ip_v4_address }
  end
end
