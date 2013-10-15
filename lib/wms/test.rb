require "wms/namespace"
require "wms/input/android_sensor"
require "wms/input/android_wifilocation"

def print_something(*args)
  puts args
end

def lockey(data)
  puts data
end


options = {
  :filepath => 'script/example_wifi.csv'
}
a = Wms::Input::AndroidWifiLocation.new
a.register(options=options)

a.run do |data| 
  print_something(data) 
end