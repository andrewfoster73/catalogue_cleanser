# frozen_string_literal: true

# Represents a user who may interact with the system
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

  # @return [String] the first_name and last_name concatenated with a space as a separator
  def full_name
    [first_name, last_name].compact.join(' ')
  end

  # Used when displaying an instance of the User class
  # @return [String] the full name and the email enclosed in parentheses
  def to_s
    "#{full_name} (#{email})"
  end

  # @return [String] the user's picture_url if set, otherwise a Gravatar retro image URL
  def image_url
    picture_url.presence || gravatar_url
  end

  private

  def gravatar_url
    "https://www.gravatar.com/avatar/#{gravatar_hash}?d=retro"
  end

  def gravatar_hash
    Digest::MD5.hexdigest(email)
  end
end
