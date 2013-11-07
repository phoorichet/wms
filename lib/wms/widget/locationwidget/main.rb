require 'wms/widget/base'

# This widget will read the location record from the event. It will then
# calculate how much time(in millisecond) did the user spend from one point to another.
#
# Input: a list of location events.
# Output: analytics 
#     {:device_id => "123456789", :widget_id = > '1', :user_id => '1',
#      :timestamp => "2013-11-06 00:01:00 -0800", 
#      :src => {:latitude => 37.4127000, longitude => -122.05854944},
#      :dest => {:latitude => 37.412619, longitude => -122.05859092},
#      :time_spent => 4888123  #(miliseconds)
#     }
#     {:device_id => "123456789", :widget_id = > '1', :user_id => '1',
#      :timestamp => "2013-11-06 00:01:30 -0800", 
#      :src => {:latitude => 37.412619, longitude => -122.05859092},
#      :dest => {:latitude => 37.4126154 longitude => -122.05854005},
#      :time_spent => 10000 #(miliseconds)
#     }

# Run the widget
#   Open rails console
#   >Widget.load_widgets
#   >widget.run_widgets
#
# Enjoy!
#

class Wms::Widget::LocationWidget < Wms::Widget::Base
  include Wms::Api::Event
  include Wms::Api::Analytic
  
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

    # Insert you code here
    
  end

end

