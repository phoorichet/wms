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

    @logger.debug @widget

    options = {
      :device_id => "12345678",
      :type => "location",
      :begin => Time.local(2013, 9, 6),
      :end => Time.local(2013, 9, 7)
    }

    @events = get_events(options)
    
    analytics = []

    (@events.count.to_i - 1).times do |i|
      cur = @events[i]
      nxt = @events[i + 1]

      analytic = {
        :device_id => "123456789",
        :widget_id => @widget.id,
        :user_id => @widget.user.id,
        :timestamp => Time.now,
        :src => {
          :latitude => cur["latitude"],
          :longitude => cur["longitude"]
        },
        :dest => {
          :latitude => nxt["latitude"],
          :longitude => nxt["longitude"]
        },
        :time_spent => (nxt["timestamp"].to_f - cur["timestamp"].to_f) * 1000.0
      }
      analytics.push(analytic)
    end
    if analytics.length > 0
      save_analytics(analytics)
    end
  end

end

