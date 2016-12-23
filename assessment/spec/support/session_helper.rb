module SessionHelper
  def sign_up_with(username, email, password, confirm_password)
      visit '/users/new'
      fill_in 'user_username', with: username
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: confirm_password
      click_button 'Sign Up'
  end
end