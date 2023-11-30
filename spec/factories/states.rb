# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { 'California' }
    symbol { 'CA' }
    fips_code { '06' }
    is_territory { false }
    lat_min { 32.5 }
    lat_max { 42.0 }
    long_min { -124.4 }
    long_max { -114.1 }
  end
end
