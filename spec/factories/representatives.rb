# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'Tim Cook' }
    title { 'Apple CEO' }
    address { 'Apple st' }
    city { 'SF' }
    state { 'CA' }
    zip { '12345' }
    political_party { 'Independent' }
    photo_url { 'http://apple.com' }
    ocdid { 'ocd-division/country:us/state:ca' }
  end
end
