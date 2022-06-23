# frozen_string_literal: true

# Enable turbo_frame variants, so that we can render different content from the
# index action in response to a Turbo Frame request.
module TurboFrameVariants
  extend ActiveSupport::Concern

  included do
    before_action :turbo_frame_request_variant
  end

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
