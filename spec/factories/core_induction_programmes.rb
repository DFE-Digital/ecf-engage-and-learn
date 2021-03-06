# frozen_string_literal: true

FactoryBot.define do
  factory :core_induction_programme do
    name { "Test Core induction programme" }
    sequence(:slug) { |n| "test-cip-#{n}" }
  end
end
