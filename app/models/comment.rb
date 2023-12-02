# frozen_string_literal: true

class Comment < ApplicationRecord
  # belongs_to :user

  audited

  validates :message, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id message updated_at]
  end

  def to_s
    message
  end
end
