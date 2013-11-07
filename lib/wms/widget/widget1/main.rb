require 'wms/widget/base'
require 'wms/api/event'

class Wms::Widget::Widget1 < Wms::Widget::Base
  include Wms::Api::Event
  
  attr_accessor :widget

  def initialize
    super
    @logger.debug "Init widget [#{self.class.name}]"
  end

  # @override
  def register(options={})
    @widget = options[:widget] 
  end

  # @override 
  def run
    # Call api
    @logger.debug "Running widget [#{self.class.name}]" 

    # Insert you code here
    @logger.debug @widget

    @events.wifi.where(:device_id => "99000204231618")

  end

  def save(data)
    self.save_anaytics(data)
  end

end

