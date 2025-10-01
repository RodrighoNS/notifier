module Notifier
  module Sendgrid
    class Config
      def self.api_key
        ENV.fetch("SENDGRID_API_KEY", ENV['SENDGRID_API_KEY'])
      end

      def self.default_from_email
        ENV.fetch("SENDGRID_FROM_EMAIL", ENV['SENDGRID_FROM_EMAIL'])
      end

      def self.validate!
        raise 'SENDGRID_API_KEY environment variable is required' unless api_key.present?
        raise 'SENDGRID_FROM_EMAIL environment variable is recommended' unless default_from_email.present?
      end
    end
  end
end
