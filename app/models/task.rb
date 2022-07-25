# frozen_string_literal: true

class Task < ApplicationRecord
  audited

  belongs_to :approved_by, optional: true

  enum status: {
    pending: 'pending',
    processing: 'processing',
    complete: 'complete',
    error: 'error'
  }

  def initialize(attributes = nil)
    super
    self.status = 'pending'
  end

  def call
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
