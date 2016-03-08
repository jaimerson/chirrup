module Notifiable
  extend ActiveSupport::Concern

  included do
    mattr_accessor :_notifiers
  end

  def notify(*args)
    _notifiers.each do |notifier|
      notifier.new(self).notify(*args)
    end
  end

  class_methods do
    def notifiers(*notifier_classes)
      self._notifiers = notifier_classes
    end
  end
end
