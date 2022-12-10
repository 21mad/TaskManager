class Task < ApplicationRecord
  belongs_to :folder

  validates :title, presence: true
end
