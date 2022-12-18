class Task < ApplicationRecord
  belongs_to :folder, optional: true # добаить миграцию на отмену null: false если будет ругаться
  belongs_to :public_folder, optional: true

  validates :title, presence: true
  validates :deadline, presence: true
end
