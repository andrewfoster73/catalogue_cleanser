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
        message: t('errors.default.message')
      },
      target: 'notifications'
    )

    respond_to do |format|
      format.html { raise }
      format.json do
        render(
          json: { error: t('errors.default.message') },
          status: :internal_server_error
        )
      end
      format.turbo_stream { raise }
    end
  end

  def show_not_found(_exception)
    respond_to do |format|
      format.html { redirect_to(resource_class, error: t('errors.not_found.message', name: resource_human_name)) }
    end
  end
end
