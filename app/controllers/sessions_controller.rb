# frozen_string_literal: true

class SessionsController < ApplicationController
  def omniauth
    session[:user_id] = user.id
    redirect_to(redirect_path_after_sign_in)
  rescue ActiveRecord::RecordInvalid
    redirect_to(:root)
  end

  def destroy
    session[:user_id] = nil
    redirect_to(:root, status: :see_other)
  end

  private

  def user
    @user ||= User.from_omniauth(request.env['omniauth.auth'])
  end

  def redirect_path_after_sign_in
    session[:user_return_to].presence || dashboard_path
  end
end
