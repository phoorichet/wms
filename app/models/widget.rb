require 'wms/namespace'
require 'wms/config/mixin'

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


  def run_widget
    # Read /widget/ for /widget/widget_name/

    # Read configuration by calling get_config() in main.rb

    # Call run() in main.rb


    data = main.run()

    data
  end

end
