# frozen_string_literal: true

require 'test_helper'

class AuditFormatterFactoryTest < ActiveSupport::TestCase
  test 'returns the correct class for a create' do
    assert_equal(
      CreateAuditFormatter,
      AuditFormatterFactory.for(action: 'create', type: 'ItemSellPack').class
    )
  end

  test 'returns the correct class for an update' do
    assert_equal(
      UpdateAuditFormatter,
      AuditFormatterFactory.for(action: 'update', type: 'ItemSellPack').class
    )
  end

  test 'returns the correct class for a destroy' do
    assert_equal(
      DestroyAuditFormatter,
      AuditFormatterFactory.for(action: 'destroy', type: 'ItemSellPack').class
    )
  end

  test 'raises an error if using an unsupported action' do
    assert_raises(AuditFormatterFactory::UnsupportedAuditActionError) do
      AuditFormatterFactory.for(action: 'copy', type: 'ItemSellPack')
    end
  end
end
