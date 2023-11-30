# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:representative) { create(:representative) }
  let(:news_item_attributes) do
    { title: 'New EV law', description: 'California news', link: 'https://googlenew.com',
   representative_id: representative.id }
  end

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    it 'assigns a new news_item as @news_item' do
      get :new, params: { representative_id: representative.id }
      expect(assigns(:news_item)).to be_a_new(NewsItem)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested news_item as @news_item' do
      news_item = create(:news_item, representative: representative)
      get :edit, params: { id: news_item.id, representative_id: representative.id }
      expect(assigns(:news_item)).to eq(news_item)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new NewsItem' do
        expect do
          post :create, params: { representative_id: representative.id, news_item: news_item_attributes }
        end.to change(NewsItem, :count).by(1)
      end

      it 'redirects to the created news_item' do
        post :create, params: { representative_id: representative.id, news_item: news_item_attributes }
        expect(response).to redirect_to(representative_news_item_path(representative, NewsItem.last))
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { representative_id: representative.id, news_item: { title: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    let!(:news_item) { create(:news_item, representative: representative) }

    context 'with valid params' do
      it 'updates the requested news_item' do
        new_attributes = { title: 'Updated Title' }
        put :update, params: { id: news_item.id, news_item: new_attributes, representative_id: representative.id }
        news_item.reload
        expect(news_item.title).to eq('Updated Title')
      end

      it 'redirects to the news_item' do
        new_attributes = { title: 'Updated Title' }
        put :update, params: { id: news_item.id, news_item: new_attributes, representative_id: representative.id }
        expect(response).to redirect_to(representative_news_item_path(representative, news_item))
      end
    end
  end
end
