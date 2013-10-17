require 'wms/namespace'
require 'wms/config/mixin'

class Widget < ActiveRecord::Base
  include Wms::Config::Mixin

  attr_accessible :collection, :config_file_path, :database, :description, 
                  :is_disable, :last_run_at, :last_run_at, :name, :run_interval, 
                  :url, :user_id, :version
  
  # Create a new Analytic object and save it into mongodb
  # @param {Hash} data Analytic data
  # @param {Integer} wid Widget id
  # @param {String} wname Widget name
  # @param {Integer} uid User id
  def create_analytic(data, wid, wname, uid)
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

  def get_analytic

  end
end
