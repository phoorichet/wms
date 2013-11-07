require 'wms/widget/base'
require 'set'

# This widget will read the wifi record from the event. It will then
# find the list of distinct wifi ssid 
# getting the unique wifi names..
#
# Input: a list of wifi events.
# Output: analytics 
#     {:device_id => "123456789", :widget_id = > '1', :user_id => '1',
#      :timestamp => "2013-11-06 00:00:00 -0800", 
#      :wifi_ssid_list => ["Cow", "Cat", "Fox"]
#     }
#     {:device_id => "123456789", :widget_id = > '1', :user_id => '1',
#      :timestamp => "2013-11-06 00:01:00 -0800", 
#      :wifi_ssid_list => ["Dog", "Whale", "Giraffe"]
#     }
#     {:device_id => "123456789", :widget_id = > '1', :user_id => '1',
#      :timestamp => "2013-11-06 00:02:00 -0800", 
#      :wifi_ssid_list => ["Fox", "Elephant", "Bird"]
#     }
#     ...
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
  
  attr_accessor :widget

  def initialize
    super
    @logger.debug "Init widget [#{self.class.name}]"
  end

  # @override
  def register(options={})
    @widget = options[:widget]
    @begin = options[:begin]
    @end = options[:end]
  end

  # @override 
  def run
    # Call api
    @logger.debug "Running widget [#{self.class.name}]" 
  
    # Insert your code here
    options = {
      #:device_id => "12345678",
      :type => "wifi_accesspoint_info",
      :begin => @begin,
      :end => @end
    }
    @events = get_events(options)
    
    analytics = []

    (@events.count.to_i).times do |i|
      wifi_arr = Set.new []
      cur = @events[i]
      wifi_lst = cur["wifi_list"]
      wifi_lst.each do |n|
        wifi_arr.add(n["SSID"])
      end 
      analytic = {
        :device_id => "123456789",
        :widget_id => @widget.id,
        :user_id => @widget.user.id,
        :timestamp => Time.now,
        :wifi_ssid_list => wifi_arr
      }
      analytics.push(analytic)
    end
    if analytics.length > 0
      save_analytics(analytics)
    end    
  end

end
