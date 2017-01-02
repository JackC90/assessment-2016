require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :price => "9.99",
      :category => 1,
      :sale_or_rent => 1,
      :description => "MyText",
      :ages => "MyString",
      :format => 1,
      :pages => 1,
      :publisher => "MyString",
      :publication_city => "MyString",
      :language => "MyString",
      :isbn => "MyString",
      :user => nil
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_category[name=?]", "product[category]"

      assert_select "input#product_sale_or_rent[name=?]", "product[sale_or_rent]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_ages[name=?]", "product[ages]"

      assert_select "input#product_format[name=?]", "product[format]"

      assert_select "input#product_pages[name=?]", "product[pages]"

      assert_select "input#product_publisher[name=?]", "product[publisher]"

      assert_select "input#product_publication_city[name=?]", "product[publication_city]"

      assert_select "input#product_language[name=?]", "product[language]"

      assert_select "input#product_isbn[name=?]", "product[isbn]"

      assert_select "input#product_user_id[name=?]", "product[user_id]"
    end
  end
end
