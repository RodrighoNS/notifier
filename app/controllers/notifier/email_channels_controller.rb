module Notifier
  class EmailChannelsController < ApplicationController
    before_action :set_email_channel, only: %i[ show edit update destroy ]

    # GET /email_channels
    def index
      @email_channels = EmailChannel.all
    end

    # GET /email_channels/1
    def show
    end

    # GET /email_channels/new
    def new
      @email_channel = EmailChannel.new
    end

    # GET /email_channels/1/edit
    def edit
    end

    # POST /email_channels
    def create
      @email_channel = EmailChannel.new(email_channel_params)

      if @email_channel.save
        redirect_to @email_channel, notice: "Email channel was successfully created."
      else
        render :new, status: :unprocessable_content
      end
    end

    # PATCH/PUT /email_channels/1
    def update
      if @email_channel.update(email_channel_params)
        redirect_to @email_channel, notice: "Email channel was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    # DELETE /email_channels/1
    def destroy
      @email_channel.destroy!
      redirect_to email_channels_path, notice: "Email channel was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_email_channel
        @email_channel = EmailChannel.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def email_channel_params
        params.expect(email_channel: [ :name ])
      end
  end
end
