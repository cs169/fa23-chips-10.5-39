# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'GET #profile' do
    before do
      user = instance_double(User)
      allow(User).to receive(:find).with(1).and_return(user)
      session[:current_user_id] = 1
    end

    it 'assigns @user based on a stubbed user' do
      get :profile
      expect(assigns(:user)).to eq(User.find(1))
    end
  end
end
