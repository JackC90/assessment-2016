require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Ages/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Publisher/)
    expect(rendered).to match(/Publication City/)
    expect(rendered).to match(/Language/)
    expect(rendered).to match(/Isbn/)
    expect(rendered).to match(//)
  end
end
