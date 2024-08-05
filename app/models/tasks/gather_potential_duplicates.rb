# frozen_string_literal: true

module Tasks
  class GatherPotentialDuplicates < Task
    def initialize(attributes = nil)
      super
      self.description = 'Look for and create any potential duplicates for each product'
    end

    protected

    def execute
      Audited.audit_class.as_user(task_id) do
        Product.kept.find_each(batch_size: 10_000) do |product|
          Queries::PotentialProductDuplicates.call(options: { product: product }).each do |potential|
            ProductDuplicate.find_or_create_by!(
              product_id: product.id,
              potential_duplicate_product_id: potential.id
            ).tap do |duplicate|
              duplicate.update!(
                certainty_percentage: duplicate.calculate_certainty_percentage(possible_dup: potential),
                item_description_similarity_score: potential.item_description_similarity,
                item_description_levenshtein_distance: potential.item_description_levenshtein,
                brand_similarity_score: potential.brand_similarity || 0
              )
            end
          end
        end
      end
    end

    private

    def task_id
      "task-gather-potential-duplicates-#{id}"
    end
  end
end
