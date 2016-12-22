class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :owner_or_admin?
  include Filterable
  
  def current_user
    session[:user_id] = nil if !User.exists?(session[:user_id])
    @current_user = User.find(session[:user_id]) if session[:user_id].present? # && User.exists?(session[:user_id])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def owner_or_admin?(model)
    if current_user == model.user
      return true
    elsif current_user.admin?
      return true
    else
      return false
    end
  end

  protected
  def authenticate_user
  	if session[:user_id]
  		@current_user = User.find(session[:user_id])
  		return true
  	else
  		redirect_to controller: "sessions", action: "login"
  		return false
  	end
  end

  def save_login_state
  	if session[:user_id]
  		redirect_to products_path
  		return false
  	else
  		return true
  	end
  end
end
