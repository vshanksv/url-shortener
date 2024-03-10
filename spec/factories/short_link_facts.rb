FactoryBot.define do
  factory :short_link_fact do
    ip { Faker::Internet.ip_v4_address }
    user_id { nil }

    trait :with_short_link do
      before(:create) do |short_link_fact|
        short_link = create(:short_link,
                            user_id: short_link_fact.user_id,
                            created_at: short_link_fact.created_at,
                            updated_at: short_link_fact.updated_at)
        short_link_fact.short_link = short_link
      end
    end
  end
end
