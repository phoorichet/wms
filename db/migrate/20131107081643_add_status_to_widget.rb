class AddStatusToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :status, :string
  end
end
