# frozen_string_literal: true

class Dashboard
  def external_products_size
    External::Product.managed.size
  end

  def tasks_awaiting_approval
    Task.requiring_approval.size
  end

  def product_issues_awaiting_confirmation
    ProductIssue.requiring_confirmation.size
  end

  def number_of_products
    @number_of_products ||= Product.kept.size
  end

  def number_of_products_used
    @number_of_products_used ||=
      Queries::ProductUsageCounts
      .call(options:
          {
            attributes: Product.catalogue_usage_attributes |
              Product.transaction_usage_attributes |
              Product.settings_usage_attributes,
            only_non_zero: true
          }
           )
      .size
  end

  def percentage_products_used
    ((Float(number_of_products_used) / Float(number_of_products)) * 100).round(2)
  end

  def percentage_products_not_used
    ((Float(number_of_products - number_of_products_used) / Float(number_of_products)) * 100).round(2)
  end

  def percentage_products_no_issues
    ((Float(number_of_products - products_with_issues) / Float(number_of_products)) * 100).round(2)
  end

  def percentage_products_with_issues
    ((Float(products_with_issues) / Float(number_of_products)) * 100).round(2)
  end

  def products_on_buy_lists
    @products_on_buy_lists ||= Product.where('buy_list_count > 0').size
  end

  def percentage_on_buy_lists
    (Float(products_on_buy_lists) / Float(number_of_products)) * 100
  end

  def products_on_priced_catalogues
    @products_on_priced_catalogues ||= Product.where('priced_catalogue_count > 0').size
  end

  def percentage_on_priced_catalogues
    (Float(products_on_priced_catalogues) / Float(number_of_products)) * 100
  end

  def products_on_transactions
    @products_on_transactions ||=
      Queries::ProductUsageCounts
      .call(options: { attributes: Product.transaction_usage_attributes, only_non_zero: true })
      .size
  end

  def percentage_on_transactions
    (Float(products_on_transactions) / Float(number_of_products)) * 100
  end

  def products_in_settings
    @products_in_settings ||=
      Queries::ProductUsageCounts
      .call(options: { attributes: Product.settings_usage_attributes, only_non_zero: true })
      .size
  end

  def percentage_in_settings
    (Float(products_in_settings) / Float(number_of_products)) * 100
  end

  def products_with_issues
    @products_with_issues = ProductIssue.products_with_issues_count
  end
end
