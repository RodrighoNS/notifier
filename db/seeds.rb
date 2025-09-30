puts "Seeding Notifier data..."

if ActiveRecord::Base.connection.table_exists?('notifier_email_channels')
  default_email_channel = Notifier::EmailChannel.find_or_initialize_by(name: "email")
  if default_email_channel.new_record?
    default_email_channel.active = true
    default_email_channel.save!
    puts "Creating default email channel..."
  end

  puts "Default email channel: #{default_email_channel.name} (ID: #{default_email_channel.id})"
  puts "Notifier seeding completed!"
else
  puts "Skipping Notifier seeding - tables not yet created. Run migrations first."
end
