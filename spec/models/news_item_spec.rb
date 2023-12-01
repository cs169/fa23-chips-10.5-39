# frozen_string_literal: true

# spec/models/news_item_spec.rb

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe '.find_for' do
    let(:representative) { Representative.create(name: 'Sample Representative') }

    context 'when a news item exists for the representative' do
      let!(:news_item) do
        described_class.create(representative: representative, title: 'Sample Title', link: 'sample_link',
                               issue: 'Terrorism')
      end

      it 'finds the news item for the representative' do
        found_item = described_class.find_for(representative.id)
        expect(found_item).to eq(news_item)
      end
    end

    context 'when no news item exists for the representative' do
      it 'returns nil' do
        found_item = described_class.find_for(representative.id)
        expect(found_item).to be_nil
      end
    end
  end
end
