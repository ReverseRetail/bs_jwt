# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BsJwt do
  it 'has a version number' do
    expect(BsJwt::VERSION).not_to be nil
  end

  describe '#process_auth0_hash/1' do
    subject { described_class.process_auth0_hash(auth0_hash) }

    context 'called with an Auth0 Hash with valid structure' do
      def valid_hash
        { 'credentials' => { 'id_token' => 'Jan.Pawel.Drugi' } }
      end

      let(:auth0_hash) { valid_hash }

      it 'calls #process_jwt/1 with the JWT token' do
        expect(described_class).to receive(:process_jwt).with('Jan.Pawel.Drugi')
        subject
      end
    end

    context 'called with nil' do
      let(:auth0_hash) { nil }
      it { expect { subject }.to raise_exception(ArgumentError) }
    end

    context 'called with invalid Hash' do
      def invalid_hash
        { 'credentials' => nil }
      end
      let(:auth0_hash) { invalid_hash }

      it { is_expected.to be false }
    end
  end

  describe '#process_jwt/1' do
    subject { described_class.process_jwt(jwt) }
    def payload
      {
        nickname: 'Jan Paweł II',
        'papiez/buddy_id' => 2137
      }
    end
    let(:key) { 'foobar' }
    let(:jwt) { JSON::JWT.new(payload).sign('foobar').to_s }

    before do
      described_class.jwks_key = key
    end

    context 'called with a JWT' do
      context 'when decoding key is valid' do
        describe 'returns parsed payload with necessary attributes' do
          it { expect(subject[:buddy_id]).to eq(2137) }
          it { expect(subject[:display_name]).to eq('Jan Paweł II') }
          it ':token field == JWT' do
            expect(subject[:token]).to eq(jwt)
          end
        end
      end

      context 'when decoding key is invalid' do
        let(:key) { 'bazbaz' }
        it { is_expected.to be false }
      end

      describe 'configuration check' do
        context 'when jwks_key is not set' do
          let(:key) { nil }

          context 'when BsJwt.auth0_domain is not set' do
            it 'raises BsJwt::ConfigMissing' do
              described_class.auth0_domain = nil
              expect { subject }.to raise_exception(BsJwt::ConfigMissing)
            end
          end

          context 'when auth0_domain is set' do
            it 'calls #fetch_jwks/0' do
              described_class.auth0_domain = 'www.example.com'
              expect(described_class).to receive(:fetch_jwks)
              subject
            end
          end
        end
      end
    end
  end
end
