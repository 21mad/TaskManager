class Task < ApplicationRecord
  belongs_to :folder

  validates :title, presence: true
  validates :deadline, presence: true
end
