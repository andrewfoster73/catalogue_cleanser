# frozen_string_literal: true

module ResourceForm
  class ComponentStories < ApplicationStories
    story :basic do
      constructor(
        title: text('Resource Title'),
        description: text('This is where the resource description is'),
        resource: klazz(ItemSellPack, name: 'carton', canonical: boolean(true)),
        token: 'token',
        action: :edit
      )
    end
  end
end
