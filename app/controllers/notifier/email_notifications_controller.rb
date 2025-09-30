module Notifier
  class EmailNotificationsController < ApplicationController
    before_action :set_email_notification, only: %i[ show edit update destroy ]

    # GET /email_notifications
    def index
      @email_notifications = EmailNotification.all
    end

    # GET /email_notifications/1
    def show
    end

    # GET /email_notifications/new
    def new
      @email_notification = EmailNotification.new
    end

    # GET /email_notifications/1/edit
    def edit
    end

    # POST /email_notifications
    def create
      @email_notification = EmailNotification.new(email_notification_params)

      if @email_notification.save
        redirect_to @email_notification, notice: "Email notification was successfully created."
      else
        render :new, status: :unprocessable_content
      end
    end

    # PATCH/PUT /email_notifications/1
    def update
      if @email_notification.update(email_notification_params)
        redirect_to @email_notification, notice: "Email notification was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    # DELETE /email_notifications/1
    def destroy
      @email_notification.destroy!
      redirect_to email_notifications_path, notice: "Email notification was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_email_notification
        @email_notification = EmailNotification.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def email_notification_params
        params.expect(email_notification: [ :title, :body, :recipient_email, :status, :priority ])
      end
  end
end
