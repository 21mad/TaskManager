require 'rails_helper'

RSpec.describe "public_folders/new", type: :view do
  before(:each) do
    assign(:public_folder, PublicFolder.new(
      name: "MyString",
      description: "MyString",
      colors: "MyText",
      members: "MyText",
      user: nil
    ))
  end

  it "renders new public_folder form" do
    render

    assert_select "form[action=?][method=?]", public_folders_path, "post" do

      assert_select "input[name=?]", "public_folder[name]"

      assert_select "input[name=?]", "public_folder[description]"

      assert_select "textarea[name=?]", "public_folder[colors]"

      assert_select "textarea[name=?]", "public_folder[members]"

      assert_select "input[name=?]", "public_folder[user_id]"
    end
  end
end
