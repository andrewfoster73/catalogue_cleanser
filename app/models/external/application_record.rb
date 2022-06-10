# frozen_string_literal: true

module External
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: { writing: :external, reading: :external }
  end
end
