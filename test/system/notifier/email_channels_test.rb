require "application_system_test_case"

module Notifier
  class EmailChannelsTest < ApplicationSystemTestCase
    setup do
      @email_channel = notifier_email_channels(:one)
    end

    test "visiting the index" do
      visit email_channels_url
      assert_selector "h1", text: "Email channels"
    end

    test "should create email channel" do
      visit email_channels_url
      click_on "New email channel"

      fill_in "Name", with: @email_channel.name
      click_on "Create Email channel"

      assert_text "Email channel was successfully created"
      click_on "Back"
    end

    test "should update Email channel" do
      visit email_channel_url(@email_channel)
      click_on "Edit this email channel", match: :first

      fill_in "Name", with: @email_channel.name
      click_on "Update Email channel"

      assert_text "Email channel was successfully updated"
      click_on "Back"
    end

    test "should destroy Email channel" do
      visit email_channel_url(@email_channel)
      click_on "Destroy this email channel", match: :first

      assert_text "Email channel was successfully destroyed"
    end
  end
end
