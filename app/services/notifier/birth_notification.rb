module Notifier
  class BirthNotification
    def self.send(notification_type, **params)
      job = Notifier::NotificationCreationJob.perform_later(
              notification_type.to_s,
              params
            )

      {
        job_id: job.job_id,
        notification_type: notification_type,
        status: "enqueued",
        enqueued_at: Time.current
      }
    end
  end
end
