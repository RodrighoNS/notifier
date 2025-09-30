class CreateNotifierEmailChannels < ActiveRecord::Migration[8.0]
  def change
    create_table :notifier_email_channels do |t|
      t.string :name, null: false
      t.boolean :active, default: false, null: false

      t.timestamps
    end
  end
end
