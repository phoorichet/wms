require 'wms/widget/base'

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

    @events.wifi.where(:device_id => "99000204231618").each do |event|

    end
    
    ''' 
    puts "Run..." 
    puts 
    event = self.events

    event.limit(10).each do |e| 
      puts e.to_json
      e.delete("_id")
      a = self.analytic.new(e.attributes)
      a.save
    end
    puts 

    #puts event.accelerometer_x = 1.0
    #event.save
    #puts @events.first.to_json
    '''
  end

  def save(data)
    self.save_anaytics(data)
  end

end

