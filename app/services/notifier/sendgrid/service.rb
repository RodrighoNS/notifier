module Notifier
  module Sendgrid
    class Service
      require 'sendgrid-ruby'
      include SendGrid

      attr_reader :api_key

      def def initialize(api_key: nil)
        @api_key = api_key

        raise ArgumentError, "Sendgrid API key is required" if @api_key.blank?
      end

      def send_email(from_email:, to_email:, subject:, content:, content_type: 'text/html')
        from = Email.new(email: from_email)
        to = Email.new(email: to_email)
        content_obj = Content.new(type: content_type, value: content)
        mail = Mail.new(from, subject, to, content_obj)

        response = sendgrid_client.client.mail._('send').post(request_body: mail.to_json)

        {
          success: response.status_code.to_i.between?(200, 299),
          status_code: response.status_code,
          body: response.body,
          headers: response.headers,
          message: success_message(response.status_code)
        }
      rescue StandardError => error
        {
          success: false,
          status_code: nil,
          body: nil,
          headers: nil,
          message: "SendGrid error: #{error.message}",
          error: error
        }
      end

      private

      def sendgrid_client
        @sendgrid_client ||= SendGrid::API.new(api_key: @api_key)
      end

      def success_message(status_code)
        case status_code.to_i
        when 202
          'Email queued for delivery'
        when 200..299
          'Email sent successfully'
        when 400
          'Bad request - check email parameters'
        when 401
          'Unauthorized - check API key'
        when 403
          'Forbidden - check permissions'
        when 413
          'Payload too large'
        when 429
          'Rate limit exceeded'
        when 500..599
          'SendGrid server error'
        else
          "Unknown status: #{status_code}"
        end
      end
    end
  end
end
