# frozen_string_literal: true

class Action < ApplicationRecord
  belongs_to :approved_by, optional: true
end
