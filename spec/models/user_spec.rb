require 'rails_helper'

RSpec.describe User do
  describe 'username format validation' do
    it 'allows username with only letters' do
      expect(build(:user, username: 'foo')).to be_valid
    end

    it 'allows username with only numbers' do
      expect(build(:user, username: '666')).to be_valid
    end

    it 'allows username with numbers and letters' do
      expect(build(:user, username: 'ch4rl13')).to be_valid
    end

    it 'allows username with underscores' do
      expect(build(:user, username: '_james')).to be_valid
    end

    it 'does not allow username with anything else' do
      expect(build(:user, username: 'batata#@!!.')).not_to be_valid
    end

    it 'validates uniqueness' do
      create(:user, username: 'fooo')
      expect(build(:user, username: 'FoOo')).not_to be_valid
    end

  end
  describe '.authenticate' do
    context 'with email and password' do
      let!(:user) { create(:user, email: 'foo@mail.com', password: 'password') }

      it 'authenticates' do
        expect(User.authenticate('foo@mail.com', 'password')).to eq(user)
      end
    end

    context 'with username and password' do
      let!(:user) { create(:user, username: 'foo', password: 'password') }

      it 'authenticates' do
        expect(User.authenticate('foo', 'password')).to eq(user)
      end
    end
  end
end
