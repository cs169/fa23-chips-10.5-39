# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { 'California' }
    fips_code { '06' }
  end
end
