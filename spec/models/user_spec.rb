require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject {
    User.new(username: "cool_user", email: "example@mail.ru", password: "password")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it 'is not valid with invalid email' do
    subject.email = 'not_an_email@@at.all'
    expect(subject).to_not be_valid
  end

  it "is not valid with short username" do
    subject.username = "user"
    expect(subject).to_not be_valid
  end

  it 'is not valid without an username' do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with the same username' do
    new_user = User.new(username: "cool_user", email: "newemail123@mail.ru", password: "password")
    expect(new_user).to be_valid
  end

  it 'is not valid with the same email' do
    new_user = User.new(username: "new_user11", email: "example@mail.ru", password: "password")
    expect(new_user).to be_valid
  end
end
