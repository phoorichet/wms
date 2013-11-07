require 'wms/widget/base'
require 'wms/api/event'

class Wms::Widget::Widget1 < Wms::Widget::Base
  include Wms::Api::Event
  
  def initialize
    super
    @logger.debug "Init widget [#{self.class.name}]"
  end

  # @override
  def register(option={})
  
  end

  # @override 
  def run
    # Call api
    @logger.debug "Running widget [#{self.class.name}]" 

    #@events.wifi.where(:device_id => "99000204231618").each do |event|
    #end

    options = {
      :device_id => "99000204231618",
      :type => "location",
      :begin => Time.local(2013, 9, 6),
      :end => Time.local(2013, 9, 6)
    }
    @events = get_events(options)

    # Compute the average speed between the start location
    # and the end location
    count = @events.length
    
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

