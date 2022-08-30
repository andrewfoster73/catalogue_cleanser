# frozen_string_literal: true

require 'test_helper'

class UpdateAuditFormatterFactoryTest < ActiveSupport::TestCase
  test 'produces friendly output' do
    assert_equal(
      'Name was changed from abbot to abbott',
      UpdateAuditFormatter.new(type: 'ItemSellPack').friendly(changes: { name: %w[abbot abbott] })
    )
  end
end
