class AddDoneByToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :done_by, :string, default: ""
  end
end
