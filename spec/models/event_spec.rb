# frozen_string_literal: true

RSpec.describe Event, type: :model do
  describe 'associations' do
    it 'belongs to a county' do
      state = State.create!(name: 'Test State', symbol: 'TS', fips_code: 'YourFipsCode', is_territory: false, lat_min: 0, lat_max: 1,
                            long_min: 0, long_max: 1)
      county = County.create!(state: state, fips_code: 1, name: 'Test State', fips_class: '')
      event = described_class.new(county: county)
      expect(event.county).to eq(county)
    end
  end

  describe 'validations' do
    it 'validates presence of start_time' do
      event = described_class.new(end_time: Time.zone.now)
      expect(event.valid?).to be false
      expect(event.errors[:start_time]).to include("can't be blank")
    end

    it 'validates presence of end_time' do
      event = described_class.new(start_time: Time.zone.now)
      expect(event.valid?).to be false
      expect(event.errors[:end_time]).to include("can't be blank")
    end
  end
end
