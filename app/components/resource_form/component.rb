# frozen_string_literal: true

module ResourceForm
  class Component < ViewComponent::Base
    include IconsHelper

    renders_many :fields, ResourceForm::FieldComponent

    attr_reader :title, :description, :resource, :token

    def initialize(title:, description:, resource:, token:)
      super
      @title = title
      @description = description
      @resource = resource
      @token = token
    end

    def form_id
      dom_id(resource, :form)
    end
  end
end
