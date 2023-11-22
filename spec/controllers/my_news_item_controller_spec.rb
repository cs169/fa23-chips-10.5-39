# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe MyNewsItemsController, type: :controller do
#   let(:representative) { create(:representative) }
#   let(:valid_attributes) do
#     { title: 'Test Title', description: 'Test Description', link: 'http://example.com',
#    representative_id: representative.id }
#   end
#   let(:invalid_attributes) { { title: '', description: '', link: '' } }
#   let(:news_item) { create(:news_item, representative: representative) }

#   describe 'GET #new' do
#     it 'assigns a new news_item as @news_item' do
#       get :new, params: { representative_id: representative.id }
#       expect(assigns(:news_item)).to be_a_new(NewsItem)
#     end
#   end

#   describe 'GET #edit' do
#     it 'assigns the requested news_item as @news_item' do
#       get :edit, params: { id: news_item.id, representative_id: representative.id }
#       expect(assigns(:news_item)).to eq(news_item)
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid params' do
#       it 'creates a new NewsItem' do
#         expect do
#           post :create, params: { news_item: valid_attributes, representative_id: representative.id }
#         end.to change(NewsItem, :count).by(1)
#       end

#       it 'redirects to the created news_item' do
#         post :create, params: { news_item: valid_attributes, representative_id: representative.id }
#         expect(response).to redirect_to(representative_news_item_path(representative, NewsItem.last))
#       end
#     end

#     context 'with invalid params' do
#       it 'returns a success response (to display the "new" template)' do
#         post :create, params: { news_item: invalid_attributes, representative_id: representative.id }
#         expect(response).to be_successful
#       end
#     end
#   end

#   describe 'PUT #update' do
#     context 'with valid params' do
#       let(:new_attributes) { { title: 'Updated Title' } }

#       it 'updates the requested news_item' do
#         put :update, params: { id: news_item.id, news_item: new_attributes, representative_id: representative.id }
#         news_item.reload
#         expect(news_item.title).to eq('Updated Title')
#       end

#       it 'redirects to the news_item' do
#         put :update, params: { id: news_item.id, news_item: new_attributes, representative_id: representative.id }
#         expect(response).to redirect_to(representative_news_item_path(representative, news_item))
#       end
#     end

#     context 'with invalid params' do
#       it 'returns a success response (to display the "edit" template)' do
#         put :update, params: { id: news_item.id, news_item: invalid_attributes, representative_id: representative.id }
#         expect(response).to be_successful
#       end
#     end
#   end

#   describe 'DELETE #destroy' do
#     it 'destroys the requested news_item' do
#       news_item # create the news_item
#       expect do
#         delete :destroy, params: { id: news_item.id, representative_id: representative.id }
#       end.to change(NewsItem, :count).by(-1)
#     end

#     it 'redirects to the news_items list' do
#       delete :destroy, params: { id: news_item.id, representative_id: representative.id }
#       expect(response).to redirect_to(representative_news_items_path(representative))
#     end
#   end
# end
