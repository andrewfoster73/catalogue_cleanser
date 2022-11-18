# frozen_string_literal: true

# This code is lifted from the Ninja repository as a temporary measure but it has been cleaned up
# to meet Rubocop standards.
# The advantage of this is performance, as the CatalogueCleanser can write directly the the database,
# The disadvantage of this is now this code exists in multiple locations.
# If the Tasks::UpdateExternalProduct class uses the P+ API to communicate changes this should not be necessary,
module External
  module ProductConcatenations
    extend ActiveSupport::Concern

    included do
      before_save :concatenate, :set_search_text
    end

    def brand_cols
      %w[brand range_model manufacturer_code]
    end

    def description_cols
      %w[
        item_description item_description_qualifier package_inner _average_weight country_of_origin
        state_province region package_quantity_length_dimension package_quantity_width_dimension
        package_quantity_height_dimension package_quantity_dimension_measure _concatenated_item_pack
      ]
    end

    def item_cols
      %w[item_size_to_s item_measure _item_pack_name]
    end

    def _concatenated_item_pack
      concatenate_cols(item_cols) unless eachy_packs?
    end

    def _item_pack_name
      return if no_item_pack_required?

      eachy?(item_pack_name) ? 'each' : item_pack_name
    end

    def no_item_pack_required?
      eachy?(item_pack_name) && (!eachy?(item_measure) || item_measure.to_s.strip == 'each')
    end

    def item_size_to_s
      format('%g', item_size) if item_size
    end

    def item_sell_quantity_to_s
      format('%g', item_sell_quantity) if item_sell_quantity
    end

    def _average_weight
      "(#{average_weight_quantity_to_s} #{average_weight_measure})" if average_weight_quantity
    end

    def average_weight_quantity_to_s
      format('%g', average_weight_quantity) if average_weight_quantity
    end

    def _concatenated_brand
      concatenate_cols(brand_cols)
    end

    def _concatenated_description
      concatenate_cols(description_cols)
    end

    def _concatenated_sell_unit
      if eachy_packs?
        'each of 1'
      else
        [
          _item_sell_pack_name,
          (item_sell_quantity.to_s.blank? ? nil : "of #{item_sell_quantity_to_s}")
        ].join(' ').strip
      end
    end

    def _item_sell_pack_name
      item_sell_quantity && item_sell_pack_name.blank? ? 'each' : item_sell_pack_name
    end

    def concatenate_cols(cols)
      cols.map { |c| send(c.to_sym) }.reject(&:blank?).join(' ')
    end

    def _search_text
      [
        _concatenated_brand,
        _concatenated_description,
        _concatenated_sell_unit
      ]
    end

    private

    def concatenate
      self.concatenated_brand = _concatenated_brand
      self.concatenated_description = _concatenated_description
      self.concatenated_sell_unit = _concatenated_sell_unit
    end

    def set_search_text
      self.search_text = _search_text
    end

    def eachy_packs?
      eachy?(item_sell_pack_name) &&
        eachy?(item_measure) &&
        (item_size == 1 || item_size.nil?) &&
        eachy?(item_pack_name)
    end

    def eachy?(str)
      str.blank? || str.strip == 'each'
    end
  end
end
