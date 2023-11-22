# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # Use a uid with alpha characters to test case sensitivity
    subject { described_class.new(uid: 'abc12345', provider: 'google_oauth2') }

    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  describe '#name' do
    let(:user) { described_class.new(first_name: 'John', last_name: 'Doe') }

    it 'returns the full name of the user' do
      expect(user.name).to eq('John Doe')
    end
  end

  describe '#auth_provider' do
    context 'when provider is google_oauth2' do
      let(:user) { described_class.new(provider: 'google_oauth2') }

      it 'returns Google' do
        expect(user.auth_provider).to eq('Google')
      end
    end

    context 'when provider is github' do
      let(:user) { described_class.new(provider: 'github') }

      it 'returns Github' do
        expect(user.auth_provider).to eq('Github')
      end
    end
  end

  describe '.find_google_user' do
    let(:uid) { 'abc12345' }

    it 'finds the user with the google_oauth2 provider' do
      described_class.create!(uid: uid, provider: 'google_oauth2')
      expect(described_class.find_google_user(uid).provider).to eq('google_oauth2')
    end
  end

  describe '.find_github_user' do
    let(:uid) { 'abc67890' }

    it 'finds the user with the github provider' do
      described_class.create!(uid: uid, provider: 'github')
      expect(described_class.find_github_user(uid).provider).to eq('github')
    end
  end
end
