module Notifier
  class EmailProcessor < NotificationProcessor
    def process(notification)
      Rails.logger.info "Processing email notification: #{notification.id}"

      sendgrid_service = Notifier::SendgridService.new
      result = sendgrid_service.send_email(
        from_email: from_email,
        to_email: notification.recipient_email,
        subject: notification.title,
        content: notification.body,
        content_type: 'text/html'
      )

      if result[:success]
        notification.update!(status: :delivered)
        Rails.logger.info "Email sent successfully to #{notification.recipient_email}"
      else
        notification.update!(status: :failed)
        Rails.logger.error "Email failed: #{result[:message]}"
      end

      result
    rescue StandardError => error
      notification.update!(status: :failed)
      Rails.logger.error "Email processing failed: #{error.message}"
      { success: false, message: "Email failed: #{error.message}", error: error }
    end

    private

    def from_email
      Notifier::SendgridConfig.default_from_email
    end
  end
end
