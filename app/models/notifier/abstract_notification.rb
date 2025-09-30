module Notifier
  class AbstractNotification < ApplicationRecord
    self.abstract_class = true

    # Polymorphic relationship to any channel type
    belongs_to :channel, polymorphic: true

    enum :status, { created: 0, on_queue: 1, delivered: 2, failed: 3 }
    enum :priority, { low: 0, medium: 1, high: 2, critical: 3 }

    validates :title, presence: true
    validates :channel, presence: true

    # Automatically assign the corresponding channel before validation
    before_validation :assign_default_channel, on: :create

    scope :pending, -> { where(status: [:created, :on_queue]) }
    scope :completed, -> { where(status: [:delivered, :failed]) }
    scope :by_priority, -> { order(:priority) }
    scope :recent, -> { order(created_at: :desc) }

    private

    def assign_default_channel
      return if channel.present?

      # Convention: EmailNotification -> EmailChannel, SmsNotification -> SmsChannel, etc.
      channel_class_name = self.class.name.gsub('Notification', 'Channel')
      channel_class = channel_class_name.constantize

      self.channel = channel_class.default
    rescue NameError => e
      raise "No corresponding channel class found for #{self.class.name}. Expected: #{channel_class_name}"
    end

    # Validate that the channel type matches the notification type
    def validate_channel_type
      expected_channel_type = self.class.name.gsub('Notification', 'Channel')

      unless channel_type == expected_channel_type
        errors.add(:channel, "must be a #{expected_channel_type}")
      end
    end
  end
end
