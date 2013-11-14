class AddCompressedToStorage < ActiveRecord::Migration
  def change
    add_column :storages, :compressed, :boolean
    add_column :storages, :device_id, :string
  end
end
