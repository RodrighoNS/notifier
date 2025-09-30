require "application_system_test_case"

module Notifier
  class EmailNotificationsTest < ApplicationSystemTestCase
    setup do
      @email_notification = notifier_email_notifications(:one)
    end

    test "visiting the index" do
      visit email_notifications_url
      assert_selector "h1", text: "Email notifications"
    end

    test "should create email notification" do
      visit email_notifications_url
      click_on "New email notification"

      fill_in "Body", with: @email_notification.body
      fill_in "Priority", with: @email_notification.priority
      fill_in "Recipient email", with: @email_notification.recipient_email
      fill_in "Status", with: @email_notification.status
      fill_in "Title", with: @email_notification.title
      click_on "Create Email notification"

      assert_text "Email notification was successfully created"
      click_on "Back"
    end

    test "should update Email notification" do
      visit email_notification_url(@email_notification)
      click_on "Edit this email notification", match: :first

      fill_in "Body", with: @email_notification.body
      fill_in "Priority", with: @email_notification.priority
      fill_in "Recipient email", with: @email_notification.recipient_email
      fill_in "Status", with: @email_notification.status
      fill_in "Title", with: @email_notification.title
      click_on "Update Email notification"

      assert_text "Email notification was successfully updated"
      click_on "Back"
    end

    test "should destroy Email notification" do
      visit email_notification_url(@email_notification)
      click_on "Destroy this email notification", match: :first

      assert_text "Email notification was successfully destroyed"
    end
  end
end
