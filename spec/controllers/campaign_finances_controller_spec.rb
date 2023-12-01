# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinancesController, type: :controller do
  describe 'GET #index' do
    before do
      allow(CampaignFinance).to receive(:get_top_candidates).and_return(['mocked_data'])
    end

    it 'fetches top candidates when cycle and category are provided' do
      get :index, params: { cycle: '2020', category: 'candidate-loan' }
      expect(assigns(:candidates)).to eq(['mocked_data'])
      expect(CampaignFinance).to have_received(:get_top_candidates).with('2020', 'candidate-loan')
    end
  end

  describe 'GET #show' do
    before do
      allow(CampaignFinance).to receive(:get_candidate).and_return('mocked_candidate')
    end

    it 'fetches a specific candidate when cycle and id are provided' do
      get :show, params: { cycle: '2020', id: 'P60007168' }
      expect(assigns(:candidate)).to eq('mocked_candidate')
      expect(CampaignFinance).to have_received(:get_candidate).with('2020', 'P60007168')
    end
  end
end
