# frozen_string_literal: true

require 'test_helper'

class CollectionHeader::ComponentTest < ViewComponent::TestCase
  test 'renders table headers using a label and sorter' do
    assert_equal(
      %(<thead id="collection_header" class="bg-gray-50">
  <tr>
      <th scope="col" class="sm:pl-6 lg:pl-8 z-20 sticky top-0 border-b border-gray-300 bg-gray-50 bg-opacity-75 px-3 py-3.5 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter">
          Email
      </th>
      <th scope="col" class="z-20 sticky top-0 border-b border-gray-300 bg-gray-50 bg-opacity-75 px-3 py-3.5 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter">
          Fake sorter
      </th>
    <th scope="col" class="z-20 sticky top-0 border-b border-gray-300 bg-gray-50 bg-opacity-75 py-3.5 pr-4 pl-3 backdrop-blur backdrop-filter sm:pr-6 lg:pr-8">
      <span class="sr-only">Actions</span>
    </th>
  </tr>
</thead>),
      render_inline(
        CollectionHeader::Component.new(
          columns: [
            { label: 'Email', classes: 'sm:pl-6 lg:pl-8' },
            { sorter: 'Fake sorter' }
          ]
        )
      ).css('#collection_header').to_html
    )
  end
end
