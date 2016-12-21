module UsersHelper
	def current_user
		@current_user ||= User.find(session[:id])
	end

	def user_signed_in?
		!@current_user.nil?
	end
end
