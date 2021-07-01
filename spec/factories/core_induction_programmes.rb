# frozen_string_literal: true

FactoryBot.define do
  factory :core_induction_programme do
    name { "Test Core induction programme" }
    sequence(:slug) { |n| "test-cip-#{n}" }

    trait :with_course_year do
      course_year_one_id { FactoryBot.create(:course_year).id }
      course_year_two_id { FactoryBot.create(:course_year).id }
    end
  end
end
