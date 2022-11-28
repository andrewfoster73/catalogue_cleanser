# frozen_string_literal: true

module ResourceForm
  class TreeSelectComponentStories < ApplicationStories
    story :basic do
      constructor(
        root_class: External::Category,
        attribute: 'category_id',
        label: 'Category',
        resource: klazz(Product),
        options: { readonly: false }
      )
    end

    story :readonly do
      constructor(
        root_class: External::Category,
        attribute: 'category_id',
        label: 'Category',
        resource: klazz(Product, category_id: External::Category.find_by(name: 'Bagels').id),
        options: { readonly: true }
      )
    end

    story :selected do
      constructor(
        root_class: External::Category,
        attribute: 'category_id',
        label: 'Category',
        resource: klazz(Product, category_id: External::Category.find_by(name: 'Bagels').id),
        options: { readonly: false }
      )
    end
  end
end
