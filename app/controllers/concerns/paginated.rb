# frozen_string_literal: true

# Provide a way to paginate collections into smaller chunks
module Paginated
  extend ActiveSupport::Concern
  include Pagy::Backend

  private

  def set_collection
    @pagy, @collection = pagy(super)
  end
end
