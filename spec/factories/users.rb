# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Barack' }
    last_name { 'Obama' }
    uid { '123456789' }
    provider { User.providers[:google_oauth2] }

    trait :github_user do
      provider { User.providers[:github] }
    end
  end
end
