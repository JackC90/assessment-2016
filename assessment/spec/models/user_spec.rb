require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
context "validations" do
	let(:valid_params1) { {username: "test321", email: "producttest321@mail.com", password:"123456", password_confirmation:"123456"} }
	let(:valid_params2) { {username: "test321no2", email: "producttest321no2@mail.com", password:"123456", password_confirmation:"123456"} }
	let(:valid_params3) { {username: "test321no3", email: "producttest321no3@mail.com", password:"123456", password_confirmation:"123456"} }
  	it "should have username, email and password" do
  		should have_db_column(:username).of_type(:string)
  		should have_db_column(:email).of_type(:string)
  		should have_db_column(:encrypted_password).of_type(:text)
  	end

  	describe "validates presence and uniqeness of email" do
  		it { is_expected.to validate_presence_of(:email) }
  		it { is_expected.to validate_uniqueness_of(:email) }
  	end

  	 describe "validates presence and uniqeness of username" do
  		it { is_expected.to validate_presence_of(:username) }
  		it { is_expected.to validate_uniqueness_of(:username) }
  	end

  	describe "validates password" do
  		it { is_expected.to validate_presence_of(:password) }
  	end

  	# happy_path
  	describe "can be created when email and password present" do
  		When(:user) { User.create(valid_params1) }
  		Then { user.valid? == true }
  	end

  	# unhappy_path
  	describe "cannot create without email" do
  		When(:user) { User.create(valid_params2.except(:email)) }
  		Then { user.valid? == false }
  	end

  	describe "cannot create without password" do
  		When(:user) { User.create(valid_params3.except(:password)) }
  		Then { user.valid? == false }
  	end

  	describe "should only permit valid email" do
  		When(:valid_user) { User.create(username: "new321", email: "hello@mail.com", password: "123456", password_confirmation: "123456") }
  		Then { valid_user.valid? == true }
  	end

  	describe "should not permit invalid email" do	
  		When(:invalid_user) { User.create(username: "new4321", email: "hellomail.com", password: "123456", password_confirmation: "123456") }
  		Then { invalid_user.valid? == false }
  	end
  end

	context "association with dependencies" do
		it { is_expected.to have_many(:products).dependent(:destroy) }
		it { is_expected.to have_many(:orders).dependent(:destroy) }
		it { is_expected.to have_one(:profile).dependent(:destroy) }
	end  
end
