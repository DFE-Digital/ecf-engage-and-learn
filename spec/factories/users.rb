# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    account_created { true }

    trait :admin do
      admin_profile { build(:admin_profile) }
      login_token { Faker::Alphanumeric.alpha(number: 10) }
      login_token_valid_until { 1.hour.from_now }
    end

    trait :induction_coordinator do
      induction_coordinator_profile { build(:induction_coordinator_profile) }
    end

    trait :early_career_teacher do
      early_career_teacher_profile { build(:early_career_teacher_profile) }
    end

    trait :mentor do
      mentor_profile { build(:mentor_profile) }
    end
  end
end
