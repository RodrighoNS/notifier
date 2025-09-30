module Notifier
  class EmailChannel < AbstractChannel
    has_many :notifications,
             -> { where(channel_type: 'Notifier::EmailChannel') },
             as: :channel,
             class_name: 'Notifier::EmailNotification'

    def self.default_name
      "Email Channel"
    end
  end
end
