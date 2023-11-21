require 'rails_helper'

RSpec.describe County, type: :model do
  describe 'std_fips_code' do
    it 'returns FIPS code with leading zeros' do
      state = State.create!(name: 'Test State')
      county = County.create!(state: state, fips_code: 1)

      expect(county.std_fips_code).to eq('001')
    end
  end
end