# frozen_string_literal: true

# Temporary User model until authentication/authorization added
class User
  include ActiveModel::API

  attr_accessor :full_name, :email
end
