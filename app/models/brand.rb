# frozen_string_literal: true

class Brand < ApplicationRecord
  include Broadcast
  include Importable

  has_many :brand_aliases, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited unless: :imported?

  before_validation :clean, unless: :imported?

  validates :name, presence: true, uniqueness: true
  validates :count, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Constructs a url that can be used to search a trademark site using the brand name
  # @param [Symbol] region a region to use when determining the trademark site to use
  # @return [String, nil] the url to use for a link to the trademark site
  def trademark_check_url(region: :au)
    return "https://search.ipaustralia.gov.au/trademarks/search/quick/result?q=#{CGI.escape(name)}" if region == :au

    nil
  end

  # A string representation of the Brand that is used whenever an instance is converted to a string
  # @return [String] the name of the Brand
  def to_s
    name
  end

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, full stop, parentheses, dash, comma, apostrophe, forward slash and space
    assign_attributes(name: name&.tr('^a-zA-Z0-9\.\(\)\-,\'/ ', ' ')&.squeeze(' ')&.strip)
  end
end
