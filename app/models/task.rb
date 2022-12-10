class Task < ApplicationRecord
  belongs_to :folder

  validates_presence_of :title
end
