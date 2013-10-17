class Widget < ActiveRecord::Base
  attr_accessible :collection, :config_file_path, :database, :description, 
                  :is_disable, :last_run_at, :last_run_at, :name, :run_interval, 
                  :url, :user_id, :version


  # Initialize the necessary settings
  def init
    
  end

  def create_analytics(data)
    
    # Create a record in MongoDB

  end

  def get_analytics
    
  end


  def run_widget
    # Read /widget/ for /widget/widget_name/

    # Read configuration by calling get_config() in main.rb

    # Call run() in main.rb


    data = main.run()

    data
  end

end
