class Widget < ActiveRecord::Base
  attr_accessible :collection, :config_file_path, :database, :description, 
                  :is_disable, :last_run_at, :last_run_at, :name, :run_interval, 
                  :url, :user_id, :version
end
