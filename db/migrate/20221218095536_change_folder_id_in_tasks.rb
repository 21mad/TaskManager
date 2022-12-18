class ChangeFolderIdInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :folder_id, :integer, null:true
  end
end
