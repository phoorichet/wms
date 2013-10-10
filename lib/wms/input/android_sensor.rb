require 'wms/namespace'
require 'wms/input/base'
require 'wms/config/mixin'
require 'csv'

class Wms::Input::AndroidSensor < Wms::Input::Base
  # Header must be defined
  config :headers, :type => Array, :default => [
        :timestamp,
        :accelerometer_x,
        :accelerometer_y,
        :accelerometer_z,
        :orientation_disabled_x,
        :orientation_isabled_y,
        :orientation_isabled_z,
        :compass_disabled_x,
        :compass_disabled_y,
        :compass_disabled_z,
        :gyro_x,
        :gyro_y,
        :gyro_z,
        :temperature_not_supported,
        :light
      ]

  attr_accessor :filepath, :headers

  public
  def register(options={})
    raise "#{self.class.name}: filepath required in options" unless options[:filepath]
    @filepath = options[:filepath]
    @headers = self.class.get_default(:headers)
  end # def register

  # Read from csv file row by row. Callback function will be called when each 
  # row is done reading.
  public
  def run(queue)
    # adding options to make data manipulation easy
    total_lines = 0
    CSV.foreach( @filepath, { :headers => @headers, 
                              :converters => [ :numeric ]
                              }) do |line|

      @logger.debug line


      total_lines += 1
    end
    @logger.debug "Total line: %d" % total_lines
  end

end
