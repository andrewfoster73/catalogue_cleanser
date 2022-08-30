# frozen_string_literal: true

require 'test_helper'

class DestroyAuditFormatterFactoryTest < ActiveSupport::TestCase
  test 'produces friendly output' do
    assert_equal(
      'Item sell pack with attributes: [Name - glaze, Canonical - false] was deleted.',
      DestroyAuditFormatter.new(type: 'ItemSellPack').friendly(changes: { name: 'glaze', canonical: false })
    )
  end
end
