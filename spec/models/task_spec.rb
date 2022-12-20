require 'rails_helper'

RSpec.describe Task, type: :model do
  subject {
    Task.new(title: "Write some tests", deadline: DateTime.now + 3)
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with empty title' do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with empty deadline' do
    subject.deadline = nil
    expect(subject).not_to be_valid
  end
end
