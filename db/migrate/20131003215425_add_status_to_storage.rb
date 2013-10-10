class AddStatusToStorage < ActiveRecord::Migration
  def change
    add_column :storages, :status, :string
  end
end
