require 'wms/namespace'
require 'wms/input/base'
require 'wms/config/mixin'
require 'csv'
require 'Time'

class Wms::Input::AndroidWifiLocation < Wms::Input::Base

  attr_accessor :filepath


  public
  def register(options={})
    raise "#{self.class.name}: filepath required in options" unless options[:filepath]
    @filepath = options[:filepath]
    
  end # def register

  # Read from csv file row by row. Callback function will be called when each 
  # row is done reading.
  public
  def run(&block)
    # adding options to make data manipulation easy
    total_lines = 0
    str_arr = []
    File.open(@filepath, "r").each_line do |line|
      str_arr = []
      str_arr << '['
      str_arr << line
      str_arr << ']'
      joined_str = str_arr.join("")
      json_obj = JSON.parse(joined_str)

      norm_json = normlaize_json_obj(json_obj)
      callback = block
      callback.call(norm_json)
      # @logger.debug ">>>>>>#{norm_json}"

      total_lines += 1
    end

    @logger.debug "Total line: %d" % total_lines
  end # end run(&block)


  #
  private
  def normlaize_json_obj(json_obj)
    normlaized_json_obj = {}
    if json_obj[0] == 'wifi_accesspoint_info' 
      normlaized_json_obj['type'] = 'wifi_accesspoint_info'
      normlaized_json_obj['timestamp'] = Time.at(json_obj[2] / 1000.0, json_obj[2] % 1000.0)
      normlaized_json_obj['device_id'] = json_obj[3]
      normlaized_json_obj['wifi_list'] = json_obj[4]['list']
      
    elsif json_obj[0] == 'location'
      normlaized_json_obj['type'] = 'location'
      normlaized_json_obj['timestamp'] = Time.at(json_obj[2] / 1000.0, json_obj[2] % 1000.0)
      normlaized_json_obj['device_id'] = json_obj[3]
      stop_at = json_obj.length - 1
      range = (4..stop_at)
      range.step(2).each do |i|
        normlaized_json_obj[json_obj[i]] = json_obj[i+1]
      end
      # @logger.debug normlaized_json_obj
    end
              
    return normlaized_json_obj
  end

end