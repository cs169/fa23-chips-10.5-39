# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:county) { create(:county) }
  let(:event_attributes) do
    { name: 'Community Meeting', description: 'Discussing community matters.', start_time: 1.day.from_now,
   end_time: 2.days.from_now, county_id: county.id }
  end
  let(:user) { create(:user) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    it 'assigns a new event as @event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event) }

    it 'assigns the requested event as @event' do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Event' do
        expect do
          post :create, params: { event: event_attributes }
        end.to change(Event, :count).by(1)
      end

      it 'redirects to the events list' do
        post :create, params: { event: event_attributes }
        expect(response).to redirect_to(events_path)
      end
    end
  end
end
