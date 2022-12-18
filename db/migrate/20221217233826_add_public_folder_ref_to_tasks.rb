class AddPublicFolderRefToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :public_folder, foreign_key: true, default: nil
  end
end
