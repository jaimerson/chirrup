require 'rails_helper'

RSpec.describe ApplicationNotifier do
  describe '#notify' do
    let!(:user) { create(:user) }
    let(:notifier) { described_class.new(user) }

    subject(:notify!) { notifier.notify(:new_follower, create(:user)) }

    it 'creates a notification' do
      expect { notify! }.to change(user.notifications, :count).by(1)
    end
  end
end
