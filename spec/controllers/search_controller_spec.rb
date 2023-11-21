# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe SearchController, type: :controller do
  describe 'search' do
    before do
      stub_request(:get, 'https://civicinfo.googleapis.com/civicinfo/v2/representatives')
        .with(query: hash_including({ address: '12345 Street Street' }))
        .to_return(
          status:  200,
          body:    {
            offices:   [],
            officials: [
              { name: 'First1 Last1', address: [{ line1: 'Address1', state: 'State1', city: 'City1', zip: 'Zip1' }],
        party: 'Political Party1', photo_url: 'PhotoUrl1' },
              { name: 'First2 Last2', address: [{ line1: 'Address2', state: 'State2', city: 'City2', zip: 'Zip2' }],
              party: 'Political Party2', photo_url: 'PhotoUrl2' }
            ]
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      get :search, params: { address: '12345 Street Street' }
      @reps = assigns(:representatives)
    end

    describe 'assigns representatives correctly' do
      before do
        get :search, params: { address: '12345 Street Street' }
        @reps = assigns(:representatives)
        @first_rep = @reps[0]
        @second_rep = @reps[1]
      end

      it 'assigns the correct number of representatives' do
        expect(@reps.length).to eq(2)
      end

      it 'rep1 has the correct name' do
        expect(@first_rep.name).to eq('First1 Last1')
      end

      it 'rep1 has the correct address' do
        expect(@first_rep.address).to eq('Address1')
      end

      it 'rep1 has the correct state' do
        expect(@first_rep.state).to eq('State1')
      end

      it 'rep1 has the correct city' do
        expect(@first_rep.city).to eq('City1')
      end

      it 'rep1 has the correct zip' do
        expect(@first_rep.zip).to eq('Zip1')
      end

      it 'rep1 has the correct political party' do
        expect(@first_rep.political_party).to eq('Political Party1')
      end

      it 'rep2 has the correct name' do
        expect(@second_rep.name).to eq('First2 Last2')
      end

      it 'rep2 has the correct address' do
        expect(@second_rep.address).to eq('Address2')
      end

      it 'rep2 has the correct state' do
        expect(@second_rep.state).to eq('State2')
      end

      it 'rep2 has the correct city' do
        expect(@second_rep.city).to eq('City2')
      end

      it 'rep2 has the correct zip' do
        expect(@second_rep.zip).to eq('Zip2')
      end

      it 'rep2 has the correct political party' do
        expect(@second_rep.political_party).to eq('Political Party2')
      end
    end
  end
end
