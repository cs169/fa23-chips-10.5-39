# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:dummy_id) { 1 }
  let(:user) { instance_double(User) }

  before do
    allow(User).to receive(:find).with(dummy_id).and_return(user)
    session[:current_user_id] = dummy_id
    get :profile
  end

  describe 'GET #profile' do
    it 'assigns @user based on the session user id' do
      expect(assigns(:user)).to eq(user)
    end
  end
end
