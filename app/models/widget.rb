require 'wms/namespace'
require 'wms/config/mixin'
require 'wms/error'
require 'rbconfig'

class Widget < ActiveRecord::Base
  include Wms::Config::Mixin

  attr_accessible :collection, :config_file_path, :database, :description, 
                  :is_disable, :last_run_at, :name, :run_interval, 
                  :url, :user_id, :version, :status

  belongs_to :user
$flag = 0

  # This method will list all the widgets that were installed.
  # The method looks up for type
  def self.load_widgets
    self.all.each do |widget|
      begin
        # Use the fixed path right now.
        main_path = "wms/#{widget.config_file_path}/main"
        logger.debug "Loading widget [#{widget.name} from #{main_path}]"
      
        require main_path
      rescue LoadError => e
        raise Wms::PluginLoadingError
      end # end begin
    end # end each
  end

  # This method will retrive widget classes and  call run method on them
  def self.run_widgets
    threads = []
    self.all.each do |widget|
      threads << Thread.new do
         begin
           # Convert class name as a string to a ruby class
           widget_class_str = "Wms::Widget::#{widget.name}"
           widget_class = widget_class_str.constantize
           widget_instance = widget_class.new
           options = {
             :widget => widget,
             :begin => Time.local(2013, 9, 6),
             :end => Time.local(2013, 9, 7)
           }
           widget_instance.register(options)
           widget_instance.run
         rescue Error => e
           puts "Error!!" 
           widget.update_attribute(:status, "failed")
         end
      end
       threads.each(&:join)
    end
  end

  def get_analytics
    Analytic.where(:widget_id => self.id, :user_id => self.user.id)
  end

  def run_widget(wid, wname, uid)
    # Read /widget/ for /widget/widget_name/

    # Read configuration by calling get_config() in main.rb

    # Call run() in main.rb


    this_file = File.expand_path("widget/" + wname + "/main.rb")
    #this_file = File.expand_path("widget/locationwidget/main.rb")
 
    ruby = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])
    
    data = `#{ruby} -r#{this_file} -e'get_data'`


    #data = main.run()

    #create_analytics(data, wid, wname, uid)
  end


end
