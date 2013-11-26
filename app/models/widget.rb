require 'wms'
require 'rbconfig'

class Widget < ActiveRecord::Base
  include Wms::Config::Mixin

  attr_accessible :description, :is_disable, :last_run_at, :name, :run_interval, :homepage, :user_id, :version, :status, :class_name

  belongs_to :user

  # This method will list all the widgets that were installed.
  # The method looks up for type
  def self.load_widgets
    self.all.each do |widget|
      # Load the path for the name
      main_path = self.name.gsub("-","/")
      logger.debug "Loading widget [#{widget.name} from #{main_path}]"
      
      begin
        require main_path
      rescue LoadError => e
        logger.error e
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
           widget_class_str = widget.class_name
           widget_class = widget_class_str.constantize
           widget_instance = widget_class.new
           options = {
             :widget => widget,
             # :begin => Time.local(2013, 9, 6),
             # :end => Time.local(2013, 9, 7)
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

  def get_analytics(page)
    Analytic.where(:widget_id => self.id, :user_id => self.user.id).page(page)
  end

end
