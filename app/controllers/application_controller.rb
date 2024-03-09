class ApplicationController < ActionController::Base
  include Pagy::Backend

  private

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout
    Current.user = nil
    reset_session
  end

  def authenticate_user!
    return if user_signed_in?

    render file: Rails.root.join('public/401.html').to_s, status: :unauthorized
  end
end
