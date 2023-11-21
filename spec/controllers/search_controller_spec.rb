require 'rails_helper'
require 'webmock/rspec'

RSpec.describe SearchController, type: :controller do
  describe 'search' do
    before do
      stub_request(:get, "https://civicinfo.googleapis.com/civicinfo/v2/representatives")
        .with(query: hash_including({address: "12345 Street Street"}))
        .to_return(
          status: 200,
	  body: {
            offices: [],
            officials: [
	      { name: "First1 Last1", address: [{line1: "Address1", state: "State1", city: "City1", zip: "Zip1"}], party: "Political Party1", photo_url: "PhotoUrl1" },
	      { name: "First2 Last2", address: [{line1: "Address2", state: "State2", city: "City2", zip: "Zip2"}], party: "Political Party2", photo_url: "PhotoUrl2" }
	    ]
	  }.to_json,
	  headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'assigns representatives correctly' do
      get :search, params: { address: '12345 Street Street' }
      reps = assigns(:representatives)
      expect(reps.length).to eq(2)
      first_rep = reps[0]
      expect(first_rep.name).to eq("First1 Last1")
      #expect(first_rep.title).to eq("Title1")
      expect(first_rep.address).to eq("Address1")
      expect(first_rep.state).to eq("State1")
      expect(first_rep.city).to eq("City1")
      expect(first_rep.zip).to eq("Zip1")
      expect(first_rep.political_party).to eq("Political Party1")
     #expect(first_rep.photo_url).to eq("PhotoUrl1") 

      second_rep = reps[1]
      expect(second_rep.name).to eq("First2 Last2")
      #expect(second_rep.title).to eq("Title2")
      expect(second_rep.address).to eq("Address2")
      expect(second_rep.state).to eq("State2")
      expect(second_rep.city).to eq("City2")
      expect(second_rep.zip).to eq("Zip2")
      expect(second_rep.political_party).to eq("Political Party2")
      #expect(second_rep.photo_url).to eq("PhotoUrl2")
    end
  end
end
