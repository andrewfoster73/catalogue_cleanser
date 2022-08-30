# frozen_string_literal: true

require 'test_helper'

class CollectionFilter::ListComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(
      CollectionFilter::ListComponent.new(
        label: 'Actions',
        attribute: :action,
        options: [
          { text: 'Create', value: 'create' },
          { text: 'Update', value: 'update' },
          { text: 'Destroy', value: 'destroy' }
        ]
      )
    )

    assert_selector('#action_list--label', text: 'Actions')
    assert_selector('#action_list--count', text: '0')
    assert_selector('input#action_list--option_0[name="q[action_in][]"][value="create"]', visible: false)
    assert_selector('label[for="action_list--option_0"]', text: 'Create', visible: false)
    assert_selector('input#action_list--option_1[name="q[action_in][]"][value="update"]', visible: false)
    assert_selector('label[for="action_list--option_1"]', text: 'Update', visible: false)
    assert_selector('input#action_list--option_2[name="q[action_in][]"][value="destroy"]', visible: false)
    assert_selector('label[for="action_list--option_2"]', text: 'Destroy', visible: false)
  end
end
