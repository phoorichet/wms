require 'wms/widget/base'

# This widget will calculate the average speed for the next 5 events for a current event. 
#
# Input: a list of wifi events.
# Output: analytics 
#     {:device_id => "123456789", :widget_id = > '1', :user_id => '1',
#      :timestamp => "2013-11-06 00:00:00 -0800", 
#      :avg_speed =>  average_speed ( speed1,speed2, speed3, speed4, speed5)
#     
# Run the widget
# Open rails console
# >Widget.load_widgets
# >widget.run_widgets
#
# Enjoy!
#

class Wms::Widget::WifiWidget < Wms::Widget::Base
  include Wms::Api::Event
  include Wms::Api::Analytic
  
  def initialize
    super
    @logger.debug "Init widget [#{self.class.name}]"
  end

  # @override
  def register(option={})
  @widget = options[:widget] 
  end

  # @override 
  def run
    # Call api
    @logger.debug "Running widget [#{self.class.name}]" 
    analytics = []
    options = {
          :type => "location",  
          :begin => Time.local(2013, 9, 6),
          :end => Time.loca(2013, 9, 6)
    }
    @events = get_events(options)
    
    
    (@events.count.to_i).times do |i|
      5.each do|i|
      cur = @events[i]
      speed_sum = speed_sum + cur["speed"]
      end 
      average_speed = sum/5
      analytic = {
        :device_id => "123456789",
        :widget_id => @widget.id,
        :user_id => @widget.user.id,
        :timestamp => Time.now,
        :avg_speed => average_speed
      }
      analytics.push(analytic)
  end
 if analytics.length > 0
      save_analytics(analytics)
    end
end



