class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :description
      t.string :version
      t.string :config_file_path
      t.string :database
      t.string :collection
      t.datetime :last_run_at
      t.integer :run_interval
      t.datetime :last_run_at
      t.boolean :is_disable
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
