# frozen_string_literal: true

module Queries
  class PotentialProductDuplicates < Base
    module Scopes
      def with_similar_item_description(item_description: nil)
        # Maximum length for levenshtein function is 255
        if item_description.length > 255
          return where('similarity(:item_description, item_description) > 0.5', item_description: item_description)
        end

        # Levenshtein is how many character manipulations to make the strings the same.
        # Using 1 as this possibly indicates a simply typo.
        where('similarity(:item_description, item_description) > 0.5 OR ' \
              'levenshtein(LOWER(:item_description), LOWER(item_description)) = 1',
              item_description: item_description
             )
      end

      def with_similar_brand(brand: nil)
        return all if brand.nil?

        where('similarity(:brand, COALESCE(brand, :brand)) > 0.8', brand: brand)
      end

      def with_similar_category(category: nil)
        return all if category.nil?

        where('similarity(:category_path, COALESCE(category_path, :category_path)) > 0.3',
              category_path: category
             )
      end

      def select_brand_similarity(brand: nil)
        return select('0 AS brand_similarity') if brand.nil?

        select(
          sanitize_sql_for_conditions(
            [
              'similarity(:brand, brand) AS brand_similarity',
              { brand: brand }
            ]
          )
        )
      end

      def select_similarity(item_description: nil)
        return select('0 AS item_description_similarity') if item_description.nil?

        select(
          sanitize_sql_for_conditions(
            [
              'similarity(:item_description, item_description) AS item_description_similarity',
              { item_description: item_description }
            ]
          )
        )
      end

      def select_levenshtein(item_description: nil)
        # Maximum length for levenshtein function is 255
        return select('0 AS item_description_levenshtein') if item_description.nil? || item_description.length > 255

        select(
          sanitize_sql_for_conditions(
            [
              'levenshtein(LOWER(:item_description::text), LOWER(item_description)) AS item_description_levenshtein',
              { item_description: item_description }
            ]
          )
        )
      end
    end

    def initialize(scope:)
      super
      @scope = scope || Product.kept
    end

    def call(options: {})
      @scope
        .extend(Scopes)
        .select('*')
        .select_similarity(item_description: options[:product].item_description)
        .select_levenshtein(item_description: options[:product].item_description)
        .select_brand_similarity(brand: options[:product].brand)
        .with_similar_item_description(item_description: options[:product].item_description)
        .with_similar_brand(brand: options[:product].brand)
        .with_similar_category(category: options[:product].category_path)
        .where.not(id: options[:product].id)
    end
  end
end
