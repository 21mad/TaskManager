require 'rails_helper'

RSpec.describe "public_folders/edit", type: :view do
  let(:public_folder) {
    PublicFolder.create!(
      name: "MyString",
      description: "MyString",
      colors: "MyText",
      members: "MyText",
      user: nil
    )
  }

  before(:each) do
    assign(:public_folder, public_folder)
  end

  it "renders the edit public_folder form" do
    render

    assert_select "form[action=?][method=?]", public_folder_path(public_folder), "post" do

      assert_select "input[name=?]", "public_folder[name]"

      assert_select "input[name=?]", "public_folder[description]"

      assert_select "textarea[name=?]", "public_folder[colors]"

      assert_select "textarea[name=?]", "public_folder[members]"

      assert_select "input[name=?]", "public_folder[user_id]"
    end
  end
end
