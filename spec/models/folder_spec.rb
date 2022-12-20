require 'rails_helper'

RSpec.describe Folder, type: :model do
  subject {
    Folder.new(name: "Cool folder for test", description: "For tests")
  }

  it 'is not valid without user_id' do
    expect(subject).to_not be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:tasks) }
  end
end
