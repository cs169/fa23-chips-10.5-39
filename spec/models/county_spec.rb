# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  describe 'std_fips_code' do
    let(:state) do
      State.create!(
        name: 'Test State', symbol: 'TS', fips_code: 'YourFipsCode',
        is_territory: false, lat_min: 0, lat_max: 1, long_min: 0, long_max: 1
      )
    end

    it 'returns FIPS code with leading zeros for single digit code' do
      county = described_class.create!(state: state, fips_code: 1, name: 'Test County', fips_class: '')
      expect(county.std_fips_code).to eq('001')
    end

    it 'returns FIPS code with leading zeros for two digit code' do
      county = described_class.create!(state: state, fips_code: 12, name: 'Another County', fips_class: '')
      expect(county.std_fips_code).to eq('012')
    end

    it 'returns FIPS code as is for three digit code' do
      county = described_class.create!(state: state, fips_code: 123, name: 'Third County', fips_class: '')
      expect(county.std_fips_code).to eq('123')
    end
  end
end
