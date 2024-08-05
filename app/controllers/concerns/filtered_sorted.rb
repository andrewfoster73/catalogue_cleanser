# frozen_string_literal: true

# Filter and sort based on user provided parameters
module FilteredSorted
  extend ActiveSupport::Concern

  included do
    prepend_before_action :set_sorting, :set_filters, only: %i[index]
  end

  private

  def set_collection
    @collection = @q.result.preload(collection_preloads).order(custom_sort_clause)
  end

  def set_filters
    @q = resource_class.ransack((params[:q] || {}).reverse_merge(default_filters))
  end

  def default_filters
    {}
  end

  def set_sorting
    @q.sorts = default_sort if @q.sorts.empty? && default_sort
  end

  def default_sort
    'created_at desc'
  end

  def custom_sort_clause
    nil
  end
end
