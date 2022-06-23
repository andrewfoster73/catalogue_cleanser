# frozen_string_literal: true

class ResourcesController < ApplicationController
  include Resources
  include Actions
  include Urls
  include Parameters
  include Paginated
  include TurboFrameVariants
end
