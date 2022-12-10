class Folder < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates_presence_of :name
end
