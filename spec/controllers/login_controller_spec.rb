# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'GET #login' do
    context 'when user is not logged in' do
      it 'renders the login view' do
        get :login
        expect(response).to render_template(:login)
      end
    end

    context 'when user is already logged in' do
      before do
        session[:current_user_id] = 1
        get :login
      end

      it 'redirects to the user profile page' do
        expect(response).to redirect_to(user_profile_path)
      end

      it 'sets a notice message' do
        expect(flash[:notice]).to match(/already logged in/)
      end
    end
  end

  describe 'POST #google_oauth2' do
    before do
      request.env['omniauth.auth'] = mock_auth_hash(:google_oauth2)
      post :google_oauth2
    end

    it 'creates a google session for the user' do
      expect(session[:current_user_id]).not_to be_nil
    end

    it 'redirects to the destination URL or root path' do
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'POST #github' do
    before do
      request.env['omniauth.auth'] = mock_auth_hash(:github)
      post :github
    end

    it 'creates a github session for the user' do
      expect(session[:current_user_id]).not_to be_nil
    end

    it 'redirects to the destination URL or root path' do
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'GET #logout' do
    before do
      session[:current_user_id] = 1
      get :logout
    end

    it 'clears the session' do
      expect(session[:current_user_id]).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'sets a logout notice message' do
      expect(flash[:notice]).to eq('You have successfully logged out.')
    end
  end

  # Mocking OAuth Responses
  def mock_auth_hash(provider)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
                                                                   provider: provider.to_s,
                                                                   uid:      '12345678910',
                                                                   info:     {
                                                                     first_name: 'Test',
                                                                     last_name:  'User',
                                                                     email:      'test@example.com'
                                                                   }
                                                                 })
  end
end
