require 'rails_helper'

RSpec.describe "public_folders/show", type: :view do
  before(:each) do
    assign(:public_folder, PublicFolder.create!(
      name: "Name",
      description: "Description",
      colors: "MyText",
      members: "MyText",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
