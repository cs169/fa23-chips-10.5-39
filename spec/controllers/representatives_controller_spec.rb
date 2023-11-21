# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #index' do
    before do
      representatives = [
        instance_double(Representative, some_method: some_value),
        instance_double(Representative, some_method: some_value)
      ]
      allow(Representative).to receive(:all).and_return(representatives)
      get :index
    end

    it 'assigns @representatives with all representatives' do
      expect(assigns(:representatives)).to match_array(Representative.all)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'when the representative exists' do
      let(:representative) { instance_double(Representative, id: 1) }

      before do
        allow(Representative).to receive(:find).with('1').and_return(representative)
      end

      it 'assigns @representative and renders show template' do
        get :show, params: { id: 1 }
        expect(assigns(:representative)).to eq(representative)
        expect(response).to render_template(:show)
      end
    end

    context 'when the representative does not exist' do
      before do
        allow(Representative).to receive(:find).with('1').and_raise(ActiveRecord::RecordNotFound)
      end

      it 'redirects to index with an error message' do
        get :show, params: { id: 1 }
        expect(response).to redirect_to(representatives_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
