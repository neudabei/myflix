class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :categories, :video_id
  end
end
