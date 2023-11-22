# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    county
    name { 'Community Meeting' }
    description { 'Discussing community matters.' }
    start_time { 1.day.from_now }
    end_time { 2.days.from_now }
  end
end
