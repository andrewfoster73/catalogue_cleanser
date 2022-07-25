# frozen_string_literal: true

class User < ApplicationRecord
  audited

  has_many :approved_tasks, class_name: 'Task', foreign_key: :approved_by_id, dependent: nil, inverse_of: :approved_by

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true

  class << self
    def from_omniauth(response)
      find_or_create_by!(uid: response[:uid], provider: response[:provider]) do |user|
        user.email = response[:info][:email]
        user.first_name = response[:info][:first_name]
        user.last_name = response[:info][:last_name]
        user.picture_url = response[:info][:image]
      end
    end
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def to_s
    "#{full_name} (#{email})"
  end
end
