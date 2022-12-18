require 'rails_helper'

RSpec.describe "public_folders/index", type: :view do
  before(:each) do
    assign(:public_folders, [
      PublicFolder.create!(
        name: "Name",
        description: "Description",
        colors: "MyText",
        members: "MyText",
        user: nil
      ),
      PublicFolder.create!(
        name: "Name",
        description: "Description",
        colors: "MyText",
        members: "MyText",
        user: nil
      )
    ])
  end

  it "renders a list of public_folders" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
