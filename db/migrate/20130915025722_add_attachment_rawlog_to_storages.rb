class AddAttachmentRawlogToStorages < ActiveRecord::Migration
  def self.up
    change_table :storages do |t|
      t.attachment :rawlog
    end
  end

  def self.down
    drop_attached_file :storages, :rawlog
  end
end
