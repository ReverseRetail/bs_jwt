# frozen_string_literal: true

RSpec.describe BsJwt do
  it 'has a version number' do
    expect(BsJwt::VERSION).not_to be nil
  end

  describe '#verify_and_decode_auth0_hash!/1' do
    context 'called with an Auth0 Hash with valid structure' do
      it 'calls #verify_and_decode!/1 with the JWT token' do
        expect(described_class).to receive(:verify_and_decode!).with('Jan.Pawel.Drugi')
        described_class.verify_and_decode_auth0_hash!('credentials' => { 'id_token' => 'Jan.Pawel.Drugi' })
      end
    end

    context 'called with nil' do
      it 'raises an ArgumentError' do
        allow(described_class).to receive(:verify_and_decode!)
        expect { described_class.verify_and_decode_auth0_hash!(nil) }.to raise_exception(ArgumentError)
      end
    end

    context 'called with invalid Hash' do
      it 'calls #verify_and_decode!/1 with nil' do
        expect(described_class).to receive(:verify_and_decode!).with(nil)
        described_class.verify_and_decode_auth0_hash!('credentials' => nil)
      end
    end
  end

  describe '#verify_and_decode!' do
    def set_auth0_domain_stub_keyset
      described_class.auth0_domain = 'reverse-retail.eu.auth0.com'
      stub_request(:get, 'https://reverse-retail.eu.auth0.com/.well-known/jwks.json')
        .to_return(status: 200, body: load_fixture('jwks.json'))
    end

    def load_fixture(name)
      File.read("./spec/fixtures/#{name}")
    end

    context 'called with a valid JWT' do
      it 'returns an Authentication instance with the right attributes' do
        set_auth0_domain_stub_keyset
        jwt = load_fixture('valid_jwt')

        actual = described_class.verify_and_decode!(jwt)

        expect(actual).to have_attributes(
          display_name: 'Jannik Graw',
          expires_at: Time.at(1529694629),
          token: jwt,
          buddy_id: 337,
          email: 'j.graw@buddyandselly.com',
          user_id: 'auth0|4e3a2fef71b571961c1b229',
          roles: ['admin']
        )
      end
    end

    context 'called with a JWT with invalid signature' do
      it 'raises an InvalidToken error' do
        set_auth0_domain_stub_keyset
        jwt = load_fixture('jwt_with_invalid_signature')

        expect { described_class.verify_and_decode!(jwt) }.to raise_error(BsJwt::InvalidToken)
      end
    end

    context 'called with a JWT signed by the wrong authority' do
      it 'raises an InvalidToken error' do
        set_auth0_domain_stub_keyset
        jwt = load_fixture('jwt_signed_by_wrong_authority')

        expect { described_class.verify_and_decode!(jwt) }.to raise_error(BsJwt::InvalidToken)
      end
    end

    context 'called with nil' do
      it 'raises an InvalidToken error' do
        expect { described_class.verify_and_decode!(nil) }.to raise_error(BsJwt::InvalidToken)
      end
    end
  end
end
