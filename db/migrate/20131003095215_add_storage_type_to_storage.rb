class AddStorageTypeToStorage < ActiveRecord::Migration
  def change
    add_column :storages, :storage_type, :string
  end
end
