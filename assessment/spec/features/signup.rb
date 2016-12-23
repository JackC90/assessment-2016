require 'rails_helper'
RSpec.feature "signup" do 
	scenario "allow user to create account" do 
		sign_up_with("Capybara", "capybara@mail.com", "123456", "123456")
		expect(page).to have_current_path("#{Capybara.default_host}#{products_path}" , url: true)
	end
end