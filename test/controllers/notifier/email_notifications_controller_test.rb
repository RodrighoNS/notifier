require "test_helper"

module Notifier
  class EmailNotificationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @email_notification = notifier_email_notifications(:one)
    end

    test "should get index" do
      get email_notifications_url
      assert_response :success
    end

    test "should get new" do
      get new_email_notification_url
      assert_response :success
    end

    test "should create email_notification" do
      assert_difference("EmailNotification.count") do
        post email_notifications_url, params: { email_notification: { body: @email_notification.body, priority: @email_notification.priority, recipient_email: @email_notification.recipient_email, status: @email_notification.status, title: @email_notification.title } }
      end

      assert_redirected_to email_notification_url(EmailNotification.last)
    end

    test "should show email_notification" do
      get email_notification_url(@email_notification)
      assert_response :success
    end

    test "should get edit" do
      get edit_email_notification_url(@email_notification)
      assert_response :success
    end

    test "should update email_notification" do
      patch email_notification_url(@email_notification), params: { email_notification: { body: @email_notification.body, priority: @email_notification.priority, recipient_email: @email_notification.recipient_email, status: @email_notification.status, title: @email_notification.title } }
      assert_redirected_to email_notification_url(@email_notification)
    end

    test "should destroy email_notification" do
      assert_difference("EmailNotification.count", -1) do
        delete email_notification_url(@email_notification)
      end

      assert_redirected_to email_notifications_url
    end
  end
end
