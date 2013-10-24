class AddUserIdIndexInWidgetTable < ActiveRecord::Migration
  def change
    add_index :widgets, :user_id
  end

end
