class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|

      t.timestamps
    end
  end
end
