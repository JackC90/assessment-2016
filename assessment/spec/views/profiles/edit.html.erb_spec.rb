require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      :name => "MyString",
      :description => "MyText",
      :whatsapp => false,
      :phone => "MyString",
      :address => "MyText",
      :user => nil
    ))
  end

  it "renders the edit profile form" do
    render

    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do

      assert_select "input#profile_name[name=?]", "profile[name]"

      assert_select "textarea#profile_description[name=?]", "profile[description]"

      assert_select "input#profile_whatsapp[name=?]", "profile[whatsapp]"

      assert_select "input#profile_phone[name=?]", "profile[phone]"

      assert_select "textarea#profile_address[name=?]", "profile[address]"

      assert_select "input#profile_user_id[name=?]", "profile[user_id]"
    end
  end
end
