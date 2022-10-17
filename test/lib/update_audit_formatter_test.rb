# frozen_string_literal: true

require 'test_helper'

class UpdateAuditFormatterFactoryTest < ActiveSupport::TestCase
  test 'produces friendly output' do
    assert_equal(
      'Item Sell Pack with changes: Name was changed from abbot to abbott',
      UpdateAuditFormatter
        .new(type: 'ItemSellPack')
        .friendly(changes: { name: %w[abbot abbott] })
    )
  end

  test 'produces friendly output when more than one attribute changed' do
    assert_equal(
      'Item Sell Pack with changes: Name was changed from abbot to abbott, Canonical was changed from Empty to true',
      UpdateAuditFormatter
        .new(type: 'ItemSellPack')
        .friendly(changes: { name: %w[abbot abbott], canonical: [nil, true] })
    )
  end
end
