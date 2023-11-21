# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    # Disabling the RSpec/ExampleLength cop for these examples
    # rubocop:disable RSpec/ExampleLength

    context 'when the representative already exists' do
      let!(:existing_rep) { described_class.create!(name: 'Alex Taylor', ocdid: 'ocd123', title: 'State Senator') }
      let(:official) { OpenStruct.new(name: 'Alex Taylor') }
      let(:office) { OpenStruct.new(name: 'State Senator', division_id: 'ocd123', official_indices: [0]) }
      let(:rep_info) { OpenStruct.new(officials: [official], offices: [office]) }

      it 'does not create a duplicate record for an existing representative' do
        expect do
          described_class.civic_api_to_representative_params(rep_info)
        end.not_to change(described_class, :count)

        existing_rep.reload
        expect(existing_rep.name).to eq('Alex Taylor')
        expect(existing_rep.ocdid).to eq('ocd123')
        expect(existing_rep.title).to eq('State Senator')
      end
    end

    context 'when the representative does not exist' do
      let(:new_official) { OpenStruct.new(name: 'Morgan Lee') }
      let(:new_office) { OpenStruct.new(name: 'State Governor', division_id: 'ocd456', official_indices: [0]) }
      let(:new_rep_info) { OpenStruct.new(officials: [new_official], offices: [new_office]) }

      it 'creates a new representative' do
        expect do
          described_class.civic_api_to_representative_params(new_rep_info)
        end.to change(described_class, :count).by(1)

        new_rep = described_class.last
        expect(new_rep.name).to eq('Morgan Lee')
        expect(new_rep.ocdid).to eq('ocd456')
        expect(new_rep.title).to eq('State Governor')
      end
    end

    # rubocop:enable RSpec/ExampleLength
  end

  context 'with all attributes' do
    let(:rep) do
      described_class.create(name: 'Test Name', title: 'President',
                             address: '1234 Orange St', city: 'Berkeley', state: 'NY',
                             zip: '91111', political_party: 'Democrat', photo_url: 'http://example.com/test.jpg')
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

    it 'has a correct party' do
      expect(rep.political_party).to eq('Democrat')
    end
  end
end
