class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?, :owner_or_admin?, :img_thumb, :img_medium, :avatar_display, :discounted

  include Filterable
  
  def current_user
    if session[:user_id].nil?
      @current_user = nil
    else
      @current_user ||= User.find(session[:user_id])
    end
  end

  def user_signed_in?
    !current_user.nil?
  end

  def owner_or_admin?(model)
    if user_signed_in?
      if current_user == model.user
        return true
      elsif current_user.admin?
        return true
      else
        return false
      end
      return false
    end
  end

  def discounted(product)
    disc = product.price * (1 - product.discount * 0.01)
  end

  def avatar_display(profile)
    if profile.avatar.present?
       return profile.avatar.thumb.url
    else
       return "http://placehold.it/300x300/808080/000000"
    end
  end

  def img_thumb(product)
    if product.product_images.present?
       return product.product_images[0].thumb.url
    else
       return "http://placehold.it/110x150/808080/000000?text=#{product.title.gsub(/\s/,'+')}"
    end
  end

  def img_medium(product)
    if product.product_images.present?
       return product.product_images[0].medium.url
    else
       return "http://placehold.it/260x400/808080/000000?text=#{product.title.gsub(/\s/,'+')}"
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
