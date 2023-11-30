# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    let(:state) { create(:state, symbol: 'CA') }
    let!(:counties) { create_list(:county, 3, state: state) }

    before do
      get :counties, params: { state_symbol: state.symbol }, xhr: true
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the counties as JSON' do
      json_response = JSON.parse(response.body)
      expected_response = counties.as_json(only: %i[id name fips_code fips_class state_id])
      actual_response = json_response.map { |county| county.slice('id', 'name', 'fips_code', 'fips_class', 'state_id') }
      expect(actual_response).to match_array(expected_response)
    end
  end
end
