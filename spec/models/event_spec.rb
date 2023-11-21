# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'model associations' do
    it 'is associated with a specific county' do
      state = State.create!(name: 'Sample State', symbol: 'SS', fips_code: 'UniqueCode',
                            is_territory: false, lat_min: 0, lat_max: 2, long_min: 0, long_max: 2)
      county = County.create!(state: state, fips_code: 2, name: 'Demo County', fips_class: 'X')
      event = described_class.new(county: county)
      expect(event.county).to eq(county)
    end
  end

  describe 'model validations' do
    it 'requires a start_time to be considered valid' do
      event = described_class.new(end_time: Time.zone.now + 1.day)
      expect(event).to be_invalid
      expect(event.errors[:start_time]).to include("can't be blank")
    end

    it 'requires an end_time to be valid' do
      event = described_class.new(start_time: Time.zone.now + 1.day)
      expect(event).to be_invalid
      expect(event.errors[:end_time]).to include("can't be blank")
    end

    it 'rejects events that start in the past' do
      event = described_class.new(start_time: 1.day.ago, end_time: Time.zone.now + 1.day)
      expect(event).to be_invalid
    end

    it 'rejects events where the end time is earlier than the start time' do
      event = described_class.new(start_time: 2.days.from_now, end_time: 1.day.from_now)
      expect(event).to be_invalid
    end
  end

  describe 'county_names_by_id functionality' do
    let(:state) do
      State.create!(
        name: 'Example State', symbol: 'EX', fips_code: 'ExCode',
        is_territory: false, lat_min: 0, lat_max: 3, long_min: 0, long_max: 3
      )
    end
    let(:county1) { County.create!(state: state, fips_code: 3, name: 'First County', fips_class: 'F') }
    let(:county2) { County.create!(state: state, fips_code: 4, name: 'Second County', fips_class: 'S') }
    let(:event) { described_class.new(county: county1) }

    it 'provides a mapping of county names to their IDs within the event state' do
      expected_map = { 'First County' => county1.id, 'Second County' => county2.id }
      expect(event.county_names_by_id).to eq(expected_map)
    end
  end
end
