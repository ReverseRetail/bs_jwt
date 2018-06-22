# frozen_string_literal: true

module BsJwt
  RSpec.describe Authentication do
    describe '#has_role?' do
      subject { build(:authentication, roles: %w[content_mgr admin]) }

      it { expect(subject.has_role?('admin')).to be true }
      it { expect(subject.has_role?('sales_mgr')).to be false }
    end

    describe '#expired?' do
      context 'when expires_at is in the future' do
        let(:authentication) { build(:authentication, expires_at: 2137.seconds.from_now) }

        it { expect(authentication).not_to be_expired }
      end

      context 'when expires_at is in the past' do
        let(:authentication) { build(:authentication, expires_at: 2137.seconds.ago) }

        it { expect(authentication).to be_expired }
      end
    end
  end
end
