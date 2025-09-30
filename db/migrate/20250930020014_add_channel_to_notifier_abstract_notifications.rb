class AddChannelToNotifierAbstractNotifications < ActiveRecord::Migration[8.0]
  def change
    add_reference :notifier_email_notifications, :channel,
                  null: false,
                  polymorphic: true,
                  index: true
  end
end
