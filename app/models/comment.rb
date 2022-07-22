# frozen_string_literal: true

class Comment < ApplicationRecord
  # belongs_to :user

  audited

  validates :message, presence: true

  def to_s
    message
  end
end
