# frozen_string_literal: true

module BsJwt
  RSpec.describe Authentication do
    describe '#has_role?' do
      it 'returns true if the given role is included in roles' do
        authentication = build(:authentication, roles: ['content-mgr', 'admin'])

        expect(authentication.has_role?('admin')).to eq true
      end

      it 'returns false if the given role is not included in role' do
        authentication = build(:authentication, roles: ['content-mgr', 'admin'])

        expect(authentication.has_role?('sales-mgr')).to eq false
      end
    end

    describe '#expired?' do
      it 'returns false if expires_at is not in the future' do
        authentication = build(:authentication, expires_at: 1.minute.from_now)

        expect(authentication.expired?).to eq false
      end

      it 'returns true if expires_at is in the future' do
        authentication = build(:authentication, expires_at: 1.minute.before)

        expect(authentication.expired?).to eq true
      end
    end
  end
end
