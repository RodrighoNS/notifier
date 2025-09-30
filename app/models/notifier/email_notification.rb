module Notifier
  class EmailNotification < AbstractNotification
    validates :recipient_email,
      presence: { message: "must be provided for email notifications" },
      format: { with: URI::MailTo::EMAIL_REGEXP }

    # Ensure the channel is always an EmailChannel
    validate :validate_channel_type

    def self.default_title
      "Email Notification title"
    end

    def self.default_body
      "This is the email notification content"
    end

    def self.default_recipient_email
      "recipient@example.com"
    end
  end
end
