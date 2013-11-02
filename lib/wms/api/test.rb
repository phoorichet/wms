require "wms/namespace"
require "wms/api/event"

class Wms::Api::Test
  include Wms::Api::Event

  def print_something(*args)
    puts args
  end

  def test_events
    options = {
      :type => "wifi_accesspoint_info",
      :begin => Time.local(2013, 9, 6),
      :end => Time.now

    }

    set_options(options)

    events do |event|
      print_something(event)
    end

  end

end

