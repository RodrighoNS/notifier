# app/jobs/notifier/priority_email_job.rb
module Notifier
  class PriorityEmailJob < ApplicationJob
    retry_on StandardError, wait: :exponentially_longer, attempts: 3

    def perform(priority, recipient_email, notification_ids)
      Rails.logger.info "Processing #{priority} priority notifications for #{recipient_email}"

      notifications = Notifier::EmailNotification.where(id: notification_ids)
      return if notifications.empty?

      # Send consolidated email for this priority only
      result = send_priority_email(priority, recipient_email, notifications)

      # Update notification status based on result
      if result[:success]
        notifications.update_all(status: :delivered, updated_at: Time.current)
        Rails.logger.info "#{priority} priority email sent successfully to #{recipient_email}"
      else
        notifications.update_all(status: :failed, updated_at: Time.current)
        Rails.logger.error "Failed to send #{priority} priority email to #{recipient_email}: #{result[:message]}"
      end
    end

    private

    def send_priority_email(priority, recipient_email, notifications)
      # Use existing SendGrid service
      sendgrid_service = Notifier::Sendgrid::Service.new(api_key: ENV['SENDGRID_API_KEY'])

      # Use your existing template but adapt it for single priority
      html_content = generate_priority_email_html(priority, notifications, recipient_email)
      subject = generate_priority_subject(priority, notifications)

      sendgrid_service.send_email(
        from_email: from_email,
        to_email: recipient_email,
        subject: subject,
        content: html_content,
        content_type: 'text/html'
      )
    end

    def generate_priority_subject(priority, notifications)
      count = notifications.count
      emoji = priority_emoji(priority)
      "#{emoji} #{count} #{priority.capitalize} Priority Notification#{count > 1 ? 's' : ''}"
    end

    def generate_priority_email_html(priority, notifications, recipient_email)
      # Reuse your existing template structure but with single priority
      priority_groups = { priority => notifications }

      renderer = ActionController::Base.new
      renderer.view_context.render(
        template: 'notifier/digest_mailer/notification_digest',
        locals: {
          priority_groups: priority_groups,
          interval: "#{priority} priority", # Adapt interval for single priority
          recipient_email: recipient_email,
          generated_at: Time.current,
          total_notifications: notifications.count
        }
      )
    end

    def priority_emoji(priority)
      case priority
      when 'critical' then '🚨'
      when 'high' then '⚠️'
      when 'medium' then '📋'
      when 'low' then '📝'
      else '📧'
      end
    end

    def from_email
      ENV['SENDGRID_FROM_EMAIL'] || 'notifications@example.com'
    end
  end
end
