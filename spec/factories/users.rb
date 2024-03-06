FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      role { User.roles[:admin] }
    end

    trait :consumer do
      role { User.roles[:consumer] }
    end
  end
end
