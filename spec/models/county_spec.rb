# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  describe 'std_fips_code' do
    it 'returns FIPS code with leading zeros' do
      state = State.create!(name: 'Test State', symbol: 'TS', fips_code: 'YourFipsCode', is_territory: false, lat_min: 0, lat_max: 1,
                            long_min: 0, long_max: 1)
      county = described_class.create!(state: state, fips_code: 1, name: 'Test State', fips_class: '')

      expect(county.std_fips_code).to eq('001')
    end
  end
end
