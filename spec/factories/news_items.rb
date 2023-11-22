# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'New EV law' }
    link { 'https://googlenew.com' }
    description { 'California news' }
    representative
  end
end
