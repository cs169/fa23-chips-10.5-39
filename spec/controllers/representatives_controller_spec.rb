# frozen_string_literal: true

# representatives_controller_spec.rb

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @representatives with all representatives' do
      representatives = [instance_double(Representative), instance_double(Representative)]
      allow(Representative).to receive(:all).and_return(representatives)
      get :index
      expect(assigns(:representatives)).to match_array(representatives)
      expect(response).to render_template(:index)
    end
  end
end
