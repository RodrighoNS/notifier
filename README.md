# Notifier
A rails engine to send Notifications through specific Channels.

## Usage in Your Rails Application

To use this engine in your Rails application, follow these steps:

### Installation

Add this line to your application's Gemfile:

```ruby
gem "notifier", git: "https://github.com/RodrighoNS/notifier.git"
```

And then execute:
```bash
$ bundle install
```

After installation, run the setup:
```bash
$ rails db:migrate
$ rails db:seed
```

### Basic Usage

```ruby
# Send an email notification (enqueued for background processing)
response = Notifier::BirthNotification.send(:email,
  title: "Welcome Email",
  body: "Welcome to our service!",
  recipient_email: "user@example.com"
)

# Returns job tracking information
puts response[:job_id]        # => Job ID for tracking
puts response[:status]        # => "enqueued"
puts response[:enqueued_at]   # => Timestamp when enqueued

# The notification will be created in the background by NotificationCreationJob
# and automatically assigned to the default email channel

# Access all notifications through the channel
channel = Notifier::EmailChannel.default
channel.notifications # => Returns all email notifications for this channel

# Check notification status
notification = Notifier::EmailNotification.last
puts notification.status      # => "created" (after job processes)
puts notification.channel.name # => "email"
```

## Development Setup

For developers who want to work on the engine itself:

### Prerequisites
- Ruby 3.4+
- Rails 8.0+
- PostgreSQL

### Setup

1. Clone the repository:
```bash
git clone https://github.com/RodrighoNS/notifier.git
cd notifier
```

2. Install dependencies:
```bash
bundle install
```

3. Setup the test database:
```bash
cd test/dummy
rails db:create
rails db:migrate
rails db:seed
```

4. Run tests:
```bash
cd ../..
rails test
```

5. Start the dummy application for testing:
```bash
cd test/dummy
rails server
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
