class AddColorsToFolder < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :colors, :text, default: "{\"red\":0,\"orange\":3,\"yellow\":7}"
  end
end
