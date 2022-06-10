# frozen_string_literal: true

class ResourcesController < ApplicationController
  include Resources
  include Actions
  include Urls
  include Parameters
end
