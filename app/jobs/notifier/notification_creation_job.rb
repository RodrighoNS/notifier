module Notifier
  class NotificationCreationJob < ApplicationJob
    queue_as :notifications

    self.queue_adapter = :solid_queue

    # Configuration for high-volume processing
    retry_on StandardError, wait: :exponentially_longer, attempts: 3
    discard_on ActiveRecord::RecordInvalid

    def perform(notification_type, params)
      Rails.logger.info "Enqueuing #{notification_type} notification with args: #{params}"

      notification = nil
      result = nil

      ActiveRecord::Base.transaction do
        notification = create_notification(notification_type, params)
      end

      Rails.logger.info "#{notification_type.capitalize} notification #{notification.id} created successfully"

      {
        notification_id: notification.id,
        notification_type: notification_type,
        processed_at: Time.current
      }

    rescue ActiveRecord::RecordInvalid => error
      Rails.logger.error "Invalid notification data: #{error.message}"
      raise

    rescue StandardError => error
      Rails.logger.error "Processing failed: #{error.message}"
      raise
    end

    private

    def create_notification(notification_type, params)
      case notification_type.to_sym
      when :email
        Notifier::EmailNotification.create!(params)
      else
        raise ArgumentError, "Unknown notification type: #{notification_type}"
      end
    end
  end
end
