class ChangeAttachmentOnStorage < ActiveRecord::Migration
  def up
    drop_attached_file :storages, :rawlog
    change_table :storages do |t|
      t.attachment :file
    end
    rename_column :storages, :storage_type, :file_type
  end

  def down
    drop_attached_file :storages, :file
    change_table :storages do |t|
      t.attachment :rawlog
    end
    rename_column :storages, :file_type, :storage_type

  end
end
