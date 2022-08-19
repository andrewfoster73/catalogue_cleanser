# frozen_string_literal: true

# Broadcast any errors to the users
module Errors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :show_error
    rescue_from ActiveRecord::RecordNotFound, with: :show_not_found
  end

  private

  def show_error(_exception)
    Turbo::StreamsChannel.broadcast_append_to(
      'errors',
      partial: 'notification',
      locals: {
        name: 'notification_error',
        type: 'error',
        message: 'We have encountered an error and cannot continue, contact us for help.'
      },
      target: 'notifications'
    )

    respond_to do |format|
      format.html { raise }
      format.json do
        render(
          json: { error: 'We have encountered an error and cannot continue, contact us for help.' },
          status: :internal_server_error
        )
      end
      format.turbo_stream { raise }
    end
  end

  def show_not_found(_exception)
    respond_to do |format|
      format.html { redirect_to(resource_class, error: "#{resource_human_name} could not be found.") }
    end
  end
end
