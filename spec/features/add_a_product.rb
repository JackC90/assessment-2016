require 'rails_helper'
RSpec.feature "add a product" do 
	scenario "allow a user to add product" do
		sign_up_with("Capybara", "capybara@mail.com", "123456", "123456")
		visit new_product_path
		fill_in "product_title", with: "Book Title"
		fill_in "product_description", with: "This is a great product."
		fill_in "product_price", with: 100.15
		select "Biology", from: "product_category"
		select "For sale", from: "product_sale_or_rent"
		select "Hardback", from: "product_format"
		select "English", from: "product_language"
		click_on("Save and Submit")

		expect(page).to have_content("Book Title")
		expect(page).to have_content("This is a great product.")
		expect(page).to have_content(100.15)
		expect(page).to have_content("Biology")
		expect(page).to have_content("For sale")
		expect(page).to have_content("Hardback")
		expect(page).to have_content("English")
	end
end