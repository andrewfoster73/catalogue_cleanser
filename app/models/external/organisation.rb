# frozen_string_literal: true

module External
  # Connects to External Organisation class
  class Organisation < External::ApplicationRecord
    self.table_name = :organisations
  end
end
