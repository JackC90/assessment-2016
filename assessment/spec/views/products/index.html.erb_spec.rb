require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :price => "9.99",
        :category => 2,
        :sale_or_rent => 3,
        :description => "MyText",
        :ages => "Ages",
        :format => 4,
        :pages => 5,
        :publisher => "Publisher",
        :publication_city => "Publication City",
        :language => "Language",
        :isbn => "Isbn",
        :user => nil
      ),
      Product.create!(
        :price => "9.99",
        :category => 2,
        :sale_or_rent => 3,
        :description => "MyText",
        :ages => "Ages",
        :format => 4,
        :pages => 5,
        :publisher => "Publisher",
        :publication_city => "Publication City",
        :language => "Language",
        :isbn => "Isbn",
        :user => nil
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Ages".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Publisher".to_s, :count => 2
    assert_select "tr>td", :text => "Publication City".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Isbn".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
