require 'rails_helper'

RSpec.describe MapController, type: :controller do
  describe 'GET #index' do
    it 'assigns @states and renders index template' do
      get :index
      expect(assigns(:states)).to eq(State.all)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #state' do
    let(:state) { double('State', counties: []) }

    before do
      allow(State).to receive(:find_by).and_return(state)
    end

    it 'assigns @state and renders state template' do
      get :state, params: { state_symbol: 'CA' }
      expect(assigns(:state)).to eq(state)
      expect(response).to render_template(:state)
    end
  end

  describe 'GET #county' do
    let(:county) { double('County') }  
    let(:state) { double('State', counties: [], id: 1) }
    
    before do
      allow(State).to receive(:find_by).and_return(state)
      allow(controller).to receive(:get_requested_county).and_return(county)
    end

    it 'assigns @county and renders the county template' do
      get :county, params: { state_symbol: 'CA', std_fips_code: '001' }
      expect(assigns(:county)).to eq(county)
      expect(response).to render_template(:county)
    end
  end
end