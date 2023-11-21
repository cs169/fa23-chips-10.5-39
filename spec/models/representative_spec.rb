# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:official) do
      OpenStruct.new(name: 'Alex Taylor', party: 'Independent', photo_url: 'http://example.com/new_photo.jpg')
    end
    let(:office) { OpenStruct.new(name: 'State Senator', division_id: 'ocd123', official_indices: [0]) }
    let(:rep_info) { OpenStruct.new(officials: [official], offices: [office]) }

    context 'when the representative already exists' do
      it 'does not create a duplicate record' do
        described_class.create!(name: 'Alex Taylor', ocdid: 'ocd123', title: 'State Senator')
        expect { described_class.civic_api_to_representative_params(rep_info) }.not_to change(described_class, :count)
      end
    end

    context 'when the representative does not exist' do
      it 'creates a new representative' do
        expect { described_class.civic_api_to_representative_params(rep_info) }.to change(described_class, :count).by(1)
      end
    end

    context 'when updating an existing representative with new information' do
      let!(:existing_rep) { described_class.create!(name: 'Alex Taylor', ocdid: 'ocd123', title: 'State Senator') }

      before { described_class.civic_api_to_representative_params(rep_info) }

      it 'updates the title' do
        existing_rep.reload
        expect(existing_rep.title).to eq('State Senator')
      end

      it 'updates the political party' do
        existing_rep.reload
        expect(existing_rep.political_party).to eq('Independent')
      end

      it 'updates the photo URL' do
        existing_rep.reload
        expect(existing_rep.photo_url).to eq('http://example.com/new_photo.jpg')
      end
    end
  end

  context 'with all attributes' do
    let(:rep) do
      described_class.create(
        name: 'Test Name', title: 'President', address: '1234 Orange St',
        city: 'Berkeley', state: 'NY', zip: '91111', political_party: 'Democrat',
        photo_url: 'http://example.com/test.jpg'
      )
    end

    it 'has a correct name' do
      expect(rep.name).to eq('Test Name')
    end

    it 'has a correct title' do
      expect(rep.title).to eq('President')
    end

    it 'has a correct address' do
      expect(rep.address).to eq('1234 Orange St')
    end

    it 'has a correct city' do
      expect(rep.city).to eq('Berkeley')
    end

    it 'has a correct state' do
      expect(rep.state).to eq('NY')
    end

    it 'has a correct zip' do
      expect(rep.zip).to eq('91111')
    end

    it 'has a correct political party' do
      expect(rep.political_party).to eq('Democrat')
    end

    it 'has a correct photo URL' do
      expect(rep.photo_url).to eq('http://example.com/test.jpg')
    end
  end
end
