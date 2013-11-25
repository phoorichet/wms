class RemoveUnusedColumnsInWidget < ActiveRecord::Migration
  def up
    remove_column :widgets, :collection
    remove_column :widgets, :config_file_path
    remove_column :widgets, :database
    rename_column :widgets, :url, :homepage

    add_column :widgets, :class_name, :string
  end

  def down
  end
end
