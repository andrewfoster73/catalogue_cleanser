# frozen_string_literal: true

module Tasks
  class InitialiseProducts < Task
    def initialize(attributes = nil)
      super
      self.description = 'Initialise the Products using the products from the P+ central (aka master) catalogue.'
    end

    protected

    def execute
      Audited.audit_class.as_user("task-initialise-products-#{id}") do
        External::Product.left_joins(:category).includes(:translations).managed.find_each do |product|
          Product.find_or_create_by!(external_product_id: product.id).tap do |p|
            # Update product with external product details
            p.update!(
              item_description: product.item_description,
              brand: product.brand,
              item_size: product.item_size,
              item_measure: product.item_measure,
              item_pack_name: product.item_pack_name,
              item_sell_quantity: product.item_sell_quantity,
              item_sell_pack_name: product.item_sell_pack_name,
              volume_in_litres: product.volume_in_litres,
              category_id: product.category_id,
              category_path: product.category&.path,
              image_file_name: product.image_file_name,
              image_updated_at: product.image_updated_at,
              locale: product.locale,
              data_source: :import
            )

            # Create translations from external product translations
            product.translations.each do |translation|
              ProductTranslation.find_or_create_by!(product: p, external_product_translation_id: translation.id) do |t|
                t.update!(
                  locale: translation.locale,
                  item_description: translation.item_description,
                  brand: translation.brand,
                  item_size: translation.item_size,
                  item_measure: translation.item_measure,
                  item_pack_name: translation.item_pack_name,
                  item_sell_quantity: translation.item_sell_quantity,
                  item_sell_pack_name: translation.item_sell_pack_name,
                  data_source: :import
                )
              end
            end

            # Look for any issues
            Product.includes(:product_translations).find(p.id).discover_and_fix_issues!
          end
        end
      end
    end
  end
end
