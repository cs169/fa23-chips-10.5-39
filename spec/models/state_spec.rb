# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable RSpec/ExampleLength
RSpec.describe State, type: :model do
  describe 'associations' do
    it 'has many counties' do
      state = described_class.create!(
        name: 'Sample State', symbol: 'SS', fips_code: '6', is_territory: false,
        lat_min: 0, lat_max: 10, long_min: 0, long_max: 10
      )
      county1 = County.create!(state: state, fips_code: 1, name: 'County One', fips_class: '')
      county2 = County.create!(state: state, fips_code: 2, name: 'County Two', fips_class: '')

      expect(state.counties).to include(county1, county2)
    end
  end

  describe 'std_fips_code' do
    it 'returns FIPS code with leading zeros for single digit code' do
      state = described_class.create!(
        name: 'Test State', symbol: 'TS', fips_code: '6', is_territory: false,
        lat_min: 0, lat_max: 10, long_min: 0, long_max: 10
      )
      expect(state.std_fips_code).to eq('06')
    end

    it 'returns FIPS code as is for two digit code' do
      state = described_class.create!(
        name: 'Another State', symbol: 'AS', fips_code: '12', is_territory: false,
        lat_min: 0, lat_max: 10, long_min: 0, long_max: 10
      )
      expect(state.std_fips_code).to eq('12')
    end
  end
end
# rubocop:enable RSpec/ExampleLength
