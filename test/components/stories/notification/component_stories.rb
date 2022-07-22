# frozen_string_literal: true

module Notification
  class ComponentStories < ApplicationStories
    story :success do
      constructor(
        name: :edit,
        type: 'success',
        message: "Item sell pack 'carton' was successfully updated."
      )
    end

    story :warning do
      constructor(
        name: :edit,
        type: 'warning',
        message: 'Another user has updated this record.'
      )
    end

    story :error do
      constructor(
        name: :edit,
        type: 'error',
        message: 'Item sell pack could not be updated.'
      )
    end

    story :information do
      constructor(
        name: :edit,
        type: 'information',
        message: "A user deleted 'carton'."
      )
    end
  end
end
