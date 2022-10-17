# frozen_string_literal: true

module IssueDiscovery
  extend ActiveSupport::Concern

  def possible_issues
    [
      missing_compulsory_attributes,
      additional_whitespace_attributes,
      ProductIssues::InvalidLocale.build(**issue_resources.merge(attribute: :locale))
    ].flatten.compact
  end

  private

  def issue_resources
    { product: self }
  end

  def missing_compulsory_attributes
    compulsory_attributes.map do |attr|
      ProductIssues::MissingCompulsory.build(**issue_resources.merge(attribute: attr))
    end
  end

  def additional_whitespace_attributes
    string_attributes.map do |attr|
      ProductIssues::AdditionalWhitespace.build(**issue_resources.merge(attribute: attr))
    end
  end

  def string_attributes
    %i[locale item_description brand item_measure item_sell_pack_name]
  end

  def compulsory_attributes
    %i[locale item_description item_size item_measure item_sell_quantity item_sell_pack_name]
  end
end
