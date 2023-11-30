# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:state) { create(:state, symbol: 'CA') }
  let(:county) { create(:county, state: state, fips_code: '001') }
  let!(:event) { create(:event, county: county) }

  describe 'GET #index' do
    context 'without filters' do
      it 'assigns all events' do
        get :index
        expect(assigns(:events)).to eq([event])
      end
    end

    context 'when filtered by state' do
      it 'assigns events from the specified state' do
        get :index, params: { 'filter-by': 'state-only', state: 'CA' }
        expect(assigns(:events)).to eq([event])
      end
    end

    context 'when filtered by county' do
      it 'assigns events from the specified county' do
        get :index, params: { 'filter-by': 'county', state: 'CA', county: '001' }
        expect(assigns(:events)).to eq([event])
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event' do
      get :show, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end
end
