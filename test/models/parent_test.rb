# frozen_string_literal: true

require 'test_helper'

module Test
  class ParentTest
    include Parent
  end
end

class ParentTest < ActiveSupport::TestCase
  test 'parent method must be implemented' do
    assert_raises(NotImplementedError) do
      Test::ParentTest.new.parent
    end
  end
end
