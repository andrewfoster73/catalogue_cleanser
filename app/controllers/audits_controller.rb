# frozen_string_literal: true

# Only renders index action containing the audits and associated audits for the parent model.
# Creation, modification and deletion of audits are prohibited
class AuditsController < ApplicationController
  include TurboFrameVariants
  include Resources
  include Urls
  include FilteredSorted
  include Paginated
  include Authenticated
  include Errors
  include Nested

  protected

  def collection_path_method
    return super unless nested?

    :"#{parent_class.name.underscore}_audits_path"
  end

  def set_filters
    return super unless nested?

    @q = parent.own_and_associated_audits.ransack((params[:q] || {}).reverse_merge(default_filters))
  end

  def default_filters
    {}
  end

  def filter_url
    return unless nested?

    @filter_url ||= public_send(collection_path_method, { parent_param => parent })
  end

  def parent_class
    @parent_class ||= parameter_introspection.id_param_class
  end

  def parent
    @parent ||= parameter_introspection.id_param_instance
  end

  def parent_param
    parameter_introspection.id_param
  end

  private

  # def resource_class
  #   @resource_class = Audited::Audit
  # end

  def parameter_introspection
    @parameter_introspection ||= ::ParameterIntrospection.new(parameters: params)
  end

  def navigation_path
    if nested?
      return begin
        public_send(:"#{parent_class.name.underscore.pluralize}_url")
      rescue StandardError
        request.original_url.split('?').first
      end
    end

    super
  end
end
