require 'rails_helper'

RSpec.describe 'User following' do
  describe 'notification on new follower' do
    let(:leader) { create(:user) }
    let(:follower) { create(:user) }

    it 'notifies the leader' do
      expect(leader).to receive(:notify)
        .with(:new_follower, follower)
      follower.follow(leader)
    end
  end
end
