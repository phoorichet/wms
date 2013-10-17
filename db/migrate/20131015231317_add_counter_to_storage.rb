class AddCounterToStorage < ActiveRecord::Migration
  def change
    add_column :storages, :count_success, :integer, :default => 0,  :null => false
    add_column :storages, :count_failure, :integer, :default => 0,  :null => false
  end
end
