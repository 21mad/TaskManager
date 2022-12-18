class CreatePublicFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :public_folders do |t|
      t.string :name
      t.string :description
      t.text :colors, default: "{\"red\":0,\"orange\":3,\"yellow\":7}"
      t.text :members, default: "[]"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
