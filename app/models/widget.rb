require 'wms/namespace'
require 'wms/config/mixin'
require 'wms/error'
require 'rbconfig'

class Widget < ActiveRecord::Base
  include Wms::Config::Mixin

  attr_accessible :collection, :config_file_path, :database, :description, 
                  :is_disable, :last_run_at, :name, :run_interval, 
                  :url, :user_id, :version

  belongs_to :user


  # testdfasdfasdfsd
  # Initialize the necessary settings
  def init
    
  end

  # This method will list all the widgets that were installed.
  # The method looks up for type
  def self.load_widgets
    self.all.each do |widget|
      begin
        # Use the fixed path right now.
        main_path = "wms/widget/#{widget.name}/main"
        logger.debug("Loading widget [#{widget.name} from #{main_path}")
      
        require main_path
      rescue LoadError => e
        raise Wms::PluginLoadingError
      end # end begin
    end # end each
  end

  # This method will retrive widget classes and  call run method on them
  def self.run_widgets
    self.all.each do |widget|
      begin
        # Convert class name as a string to a ruby class
        widget_class_str = "Wms::Widget::#{widget.name}"
        widget_class = widget_class_str.constantize
        widget_instance = widget_class.new
        widget_instance.run
      rescue Error => e
        puts "Error!!" 
      end
    end
  end

  # Create a new Analytic object and save it into mongodb
  # @param {Hash} data Analytic data
  # @param {Integer} wid Widget id
  # @param {String} wname Widget name
  # @param {Integer} uid User id
  def create_analytics(data, wid, wname, uid)
    config = source("widget/" + wname + "/config.yml")
    attr_name = config[:development][:attributes]
    
    analytic = Analytic.new
    analytic.widget_id = wid
    analytic.user_id = uid

    attr_name.each do |attr|
      if data.has_key?(attr)
        analytic.write_attribute(attr, data[attr])
      else
        raise "Analytic data attribute does not match config file"
      end
    end   
    analytic.save
  end

  # Get all the analytics records of one widget
  # @param {Integer} wid Widget id
  # @return {Array} analytics Array of Analytic objects
  def get_analytics(wid)
    analytics = Analytic.where(widget_id: wid)
    return analytics
  end


  def run_widget(wid, wname, uid)
    # Read /widget/ for /widget/widget_name/

    # Read configuration by calling get_config() in main.rb

    # Call run() in main.rb


    this_file = File.expand_path("widget/" + wname + "/main.rb")
 
    ruby = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])
    
    data = `#{ruby} -r#{this_file} -e'get_data'`


    #data = main.run()

    #create_analytics(data, wid, wname, uid)
  end

end
