class CreateNotifierEmailNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifier_email_notifications do |t|
      t.string :title
      t.string :body
      t.string :recipient_email
      t.integer :status, null: false, default: 0
      t.integer :priority, null: false, default: 0

      t.timestamps
    end
  end
end
