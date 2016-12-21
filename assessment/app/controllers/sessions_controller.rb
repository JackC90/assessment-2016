class SessionsController < ApplicationController
  before_filter :authenticate_user, only: [:profile, :setting]
  before_filter :save_login_state, only: [:login, :login_attempt]

  def login
  end

  def login_attempt
  	authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
  	respond_to do |format|
  		if authorized_user
  			session[:user_id] = authorized_user.id
  			format.html { redirect_to new_user_path, notice: "You are logged in as #{authorized_user.username}!" }
  			format.json { render :show, status: :created, location: root_path }
  		else
  			format.html { render "sessions/login", notice: "Failed to log in." }
  			format. json { render json: @user.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def logout
  	session[:user_id] 	= nil
 	@current_user 		= nil
  	redirect_to controller: "sessions", action: "login"
  end
end
