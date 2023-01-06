# frozen_string_literal: true

# Keep track of what resources have been manually edited after having been imported
module ManuallyEditable
  extend ActiveSupport::Concern

  private

  def resource_params
    # As soon as a user manually edits an imported resource the data source needs to change
    # to manual so the before_validation callback in the model is triggered
    super.merge(data_source: 'manual')
  end
end
