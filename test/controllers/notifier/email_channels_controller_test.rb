require "test_helper"

module Notifier
  class EmailChannelsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @email_channel = notifier_email_channels(:one)
    end

    test "should get index" do
      get email_channels_url
      assert_response :success
    end

    test "should get new" do
      get new_email_channel_url
      assert_response :success
    end

    test "should create email_channel" do
      assert_difference("EmailChannel.count") do
        post email_channels_url, params: { email_channel: { name: @email_channel.name } }
      end

      assert_redirected_to email_channel_url(EmailChannel.last)
    end

    test "should show email_channel" do
      get email_channel_url(@email_channel)
      assert_response :success
    end

    test "should get edit" do
      get edit_email_channel_url(@email_channel)
      assert_response :success
    end

    test "should update email_channel" do
      patch email_channel_url(@email_channel), params: { email_channel: { name: @email_channel.name } }
      assert_redirected_to email_channel_url(@email_channel)
    end

    test "should destroy email_channel" do
      assert_difference("EmailChannel.count", -1) do
        delete email_channel_url(@email_channel)
      end

      assert_redirected_to email_channels_url
    end
  end
end
