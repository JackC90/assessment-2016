require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { User.create(username: "test321", email: "producttest321@mail.com", password:"123456", password_confirmation:"123456") }
  let(:valid_params) {{
  	user_id: user.to_param,
  	title: "testing title", 
  	description: "testing description", 
  	price: 200.00,
  	sale_or_rent: 1,
  	discount: 20,
  	category: 1
  	}}

  context "validations" do
  	it "should have all columns for product details" do
  		should have_db_column(:title).of_type(:string)
  		should have_db_column(:description).of_type(:text)
  		should have_db_column(:price).of_type(:decimal)
  		should have_db_column(:category).of_type(:integer)
  		should have_db_column(:sale_or_rent).of_type(:integer)
  	end

  	describe "validates presence of title" do
  		it { is_expected.to validate_presence_of(:title) }
  	end 

  	describe "validates presence of category" do
  		it { is_expected.to validate_presence_of(:category) }
  	end

  	describe "validates presence of price" do
  		it { is_expected.to validate_presence_of(:price) }
  	end

  	describe "validates presence of sale_or_rent" do
  		it { is_expected.to validate_presence_of(:sale_or_rent) }
  	end

  	describe "validates discount range" do
  		it { is_expected.to validate_inclusion_of(:discount).in_range(0..100) }
  	end

  	#happy_path
  	describe "can be created when valid details present" do
  		When(:product) { user.products.create(valid_params) }
  		Then { product.valid? == true }
  	end

  	#unhappy_path
  	describe "cannot create without title" do
  		When(:product) { user.products.create(valid_params.except(:title)) }
  		Then { product.valid? == false }
  	end

  	describe "cannot create without sale_or_rent" do
  		When(:product) { user.products.create(valid_params.except(:sale_or_rent)) }
  		Then { product.valid? == false }
  	end

  	describe "cannot create without price" do
  		When(:product) { user.products.create(valid_params.except(:price)) }
  		Then { product.valid? == false }
  	end
  end

  context "association with dependencies" do
  	it { is_expected.to belong_to(:user) }
  	it { is_expected.to have_many(:orders).dependent(:destroy) }
  end
end
