# frozen_string_literal: true

class ResourcesController < ApplicationController
  include TurboFrameVariants
  include Resources
  include Actions
  include Urls
  include Parameters
  include FilteredSorted
  include Paginated
  include Authenticated
end
