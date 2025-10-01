# app/jobs/notifier/notification_digest_job.rb
module Notifier
  class NotificationDigestJob < ApplicationJob
    queue_as :default

    retry_on StandardError, wait: :exponentially_longer, attempts: 3

    def perform
      Rails.logger.info "Starting notification review process"

      # Find all created notifications
      notifications = Notifier::EmailNotification
                        .where(status: :created)
                        .includes(:channel)

      return if notifications.empty?

      # Group by priority and recipient_email
      grouped_notifications = group_notifications(notifications)

      # Enqueue to priority-specific queues and update status
      grouped_notifications.each do |priority, recipient_groups|
        recipient_groups.each do |recipient_email, notifications_array|
          enqueue_priority_job(priority, recipient_email, notifications_array)
          update_notifications_status(notifications_array)
        end
      end

      Rails.logger.info "Notification review completed: #{notifications.count} notifications processed"
    end

    private

    def group_notifications(notifications)
      # Group first by priority, then by recipient_email
      notifications.group_by(&:priority).transform_values do |priority_notifications|
        priority_notifications.group_by(&:recipient_email)
      end
    end

    def enqueue_priority_job(priority, recipient_email, notifications)
      notification_ids = notifications.map(&:id)

      case priority
      when 'critical'
        Notifier::PriorityEmailJob.set(queue: :critical).perform_later(priority, recipient_email, notification_ids)
      when 'high'
        Notifier::PriorityEmailJob.set(queue: :high).perform_later(priority, recipient_email, notification_ids)
      when 'medium'
        Notifier::PriorityEmailJob.set(queue: :medium).perform_later(priority, recipient_email, notification_ids)
      when 'low'
        Notifier::PriorityEmailJob.set(queue: :low).perform_later(priority, recipient_email, notification_ids)
      end
    end

    def update_notifications_status(notifications)
      notification_ids = notifications.map(&:id)
      Notifier::EmailNotification.where(id: notification_ids).update_all(
        status: :on_queue,
        updated_at: Time.current
      )
    end
  end
end
