# frozen_string_literal: true

class Task < ApplicationRecord
  audited

  belongs_to :approved_by, optional: true
  belongs_to :context, polymorphic: true, optional: true
  belongs_to :product_issue, polymorphic: true, optional: true

  scope :requiring_approval, -> { where(requires_approval: true) }
  scope :requiring_confirmation, -> { where(status: 'pending') }

  enum status: {
    pending: 'pending',
    processing: 'processing',
    complete: 'complete',
    error: 'error'
  }

  def initialize(attributes = nil)
    super
    self.status = 'pending'
    self.description ||= 'This is a base task, it does nothing.'
  end

  def call
    return if requires_approval? && !approved

    processing!
    execute
    complete!
  rescue NotImplementedError, StandardError => e
    self.error = e.full_message
    self.backtrace = e.backtrace
    error!
    raise(e)
  end

  def to_s
    description
  end

  protected

  # Action logic should be implemented here
  def execute
    raise(NotImplementedError)
  end
end
