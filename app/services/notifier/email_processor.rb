module Notifier
  class EmailProcessor < NotificationProcessor
    def process(notification)
      puts "Processing email notification: #{notification}"

      # ... Email specific logic (SendGrid) ...

      # Update notification status
      # notification.update!(status: :delivered)

      { success: true, message: "Email sent successfully!" }
    rescue StandardError => error
      notification.update!(status: :failed)
      { success: false, message: "Email failed: #{error.message}" }
    end
  end
end
