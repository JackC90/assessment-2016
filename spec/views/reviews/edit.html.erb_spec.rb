require 'rails_helper'

RSpec.describe "reviews/edit", type: :view do
  before(:each) do
    @review = assign(:review, Review.create!(
      :title => "MyString",
      :text => "MyText",
      :rating => 1,
      :user => nil,
      :product => nil
    ))
  end

  it "renders the edit review form" do
    render

    assert_select "form[action=?][method=?]", review_path(@review), "post" do

      assert_select "input#review_title[name=?]", "review[title]"

      assert_select "textarea#review_text[name=?]", "review[text]"

      assert_select "input#review_rating[name=?]", "review[rating]"

      assert_select "input#review_user_id[name=?]", "review[user_id]"

      assert_select "input#review_product_id[name=?]", "review[product_id]"
    end
  end
end
