FactoryBot.define do
  factory :user do
    nickname { "テスト" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "passwordpassword" }
  end
end
