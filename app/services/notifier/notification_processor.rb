module Notifier
  class NotificationProcessor
    def process(notification)
      raise NotImplementedError, "Subclasses must implement the process method"
    end
  end
end
