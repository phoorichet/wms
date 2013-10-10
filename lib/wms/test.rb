require "wms/namespace"
require "wms/input/android_sensor"
options = {
  :filepath => 'script/example_sensor.csv'
}
a = Wms::Input::AndroidSensor.new
a.register(options=options)
a.run(nil)