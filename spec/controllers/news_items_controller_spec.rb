# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let!(:news_item) { create(:news_item, representative: representative) }

  describe 'GET #index' do
    it 'assigns all news_items of the representative' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq([news_item])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested news_item' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
    end
  end
end
