# frozen_string_literal: true

# Redirect user to root page if they are not authenticated
module Authenticated
  extend ActiveSupport::Concern

  included do
    before_action :snaffle_current_path, :authenticate_user!
    helper_method :user_signed_in?, :current_user
  end

  protected

  def authenticate_user!
    redirect_to(:root) unless user_signed_in?
  end

  def user_signed_in?
    current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def snaffle_current_path
    session[:user_return_to] = request.fullpath
  end
end
