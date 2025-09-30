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
# Create an email notification
notification = Notifier::EmailNotification.create!(
  title: "Welcome Email",
  body: "Welcome to our service!",
  recipient_email: "user@example.com"
)

# The notification is automatically assigned to the default email channel
notification.channel # => #<Notifier::EmailChannel name: "email">

# Access notifications through the channel
channel = Notifier::EmailChannel.default
channel.notifications # => [notification]
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
