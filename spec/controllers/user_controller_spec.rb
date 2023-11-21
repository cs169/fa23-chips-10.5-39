require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'GET #profile' do
    it 'assigns @user based on a stubbed user' do
      dummy_id = 1
      user = double('User')
      allow(User).to receive(:find).with(dummy_id).and_return(user)
      session[:current_user_id] = dummy_id
      get :profile
      expect(assigns(:user)).to eq(user)
    end
  end
end