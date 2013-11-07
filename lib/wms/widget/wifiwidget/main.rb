require 'wms/widget/base'

# This widget will read the wifi record from the event. It will then
# find the list of distinct wifi ssid within 1-hour window.
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
  end

  # @override 
  def run
    # Call api
    @logger.debug "Running widget [#{self.class.name}]" 
  
    # Insert your code here
    @logger.debug @widget
  end

end


