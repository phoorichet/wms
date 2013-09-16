class AddUserAndStorageRelationship < ActiveRecord::Migration
  def up
    add_column :storages, :user_id, :integer
    add_index :storages, :user_id
  end

  def down
    remove_index :storages, :user_id
    remove_column :storages, :user_id
  end
end
