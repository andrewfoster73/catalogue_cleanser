# frozen_string_literal: true

module ResourceForm
  class TimestampComponentStories < ApplicationStories
    story :basic do
      constructor(
        attribute: text('created_at'),
        label: text('Created At'),
        resource: klazz(ItemSellPack, name: 'carton', canonical: true, created_at: date(Time.zone.today)),
        readonly: boolean(true)
      )
    end
  end
end
