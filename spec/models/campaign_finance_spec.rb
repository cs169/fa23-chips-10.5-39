# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinance, type: :model do
  describe '.search_candidates' do
    let(:cycle) { '2020' }
    let(:query) { 'Wilson' }
    let(:stubbed_response) { { 'results' => [{ 'name' => 'Wilson' }] }.to_json }

    before do
      stub_request(:get, "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/search.json?query=#{query}")
        .to_return(status: 200, body: stubbed_response)
    end

    it 'fetches candidates based on the query' do
      result = described_class.search_candidates(cycle, query)
      expect(result['results'].first['name']).to eq('Wilson')
    end
  end
end
