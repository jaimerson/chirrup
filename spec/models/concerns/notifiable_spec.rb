require 'rails_helper'

RSpec.describe Notifiable do
  DummyNotifier = Struct.new(:user)
  NullNotifier = Struct.new(:user)

  class Dummy
    include Notifiable
    notifiers DummyNotifier, NullNotifier
  end

  describe '#notify' do
    let(:dummy_notifier) { double }
    let(:null_notifier) { double }

    it 'calls #notify on each of the notifiers' do
      dummy = Dummy.new
      allow(DummyNotifier).to receive(:new).with(dummy).and_return(dummy_notifier)
      allow(NullNotifier).to receive(:new).with(dummy).and_return(null_notifier)

      expect(dummy_notifier).to receive(:notify).with(:foo)
      expect(null_notifier).to receive(:notify).with(:foo)

      dummy.notify(:foo)
    end
  end
end
