require 'json'
require 'csv'
require 'logger'
require 'date'
require 'mongo'

class WmsSystemParser
  attr_accessor :csv_file_path, :logger
  
  include Mongo

  def initialize(csv_file_path)
    # super
    @csv_file_path = csv_file_path
    @logger = Logger.new(STDOUT)

    # Connect to mongodb
    @mongo_client = MongoClient.new("ciscoteam", 27017)
    @db = @mongo_client.db("test")
    @rawdata = @db.collection("rawdata")
    @logger.debug @mongo_client.database_names
  end

  def run
    # adding options to make data manipulation easy
    total_lines = 0
    # str_arr = []
    File.open(@csv_file_path, "r").each_line do |line|
      str_arr = []
      # name: "Angela"    job: "Writer"    ...
      # data = line.split(/\t/)
      # name, job = data.map{|d| d.split(": ")[1] }.flatten
      str_arr << '['
      str_arr << line
      str_arr << ']'
      joined_str = str_arr.join("")
      # @logger.debug joined_str
      json_obj = JSON.parse(joined_str)
      # @logger.debug json_obj[4]['list']
      # @logger.info Time.at(json_obj[4])

      norm_json = self.normlaize_json_obj(json_obj)
      self.write_db(norm_json)

      total_lines += 1
      # if total_lines == 100 
      #   break
      # end
    end


    @logger.debug "Total line: %d" % total_lines
  end

  def normlaize_json_obj(json_obj)
    normlaized_json_obj = {}
    if json_obj[0] == 'wifi_accesspoint_info' 
      normlaized_json_obj['type'] = 'wifi_accesspoint_info'
      normlaized_json_obj['timestamp'] = Time.at(json_obj[2] / 1000.0)
      normlaized_json_obj['device_id'] = json_obj[3]
      normlaized_json_obj['wifi_list'] = json_obj[4]['list']
      # @logger.debug normlaized_json_obj
    elsif json_obj[0] == 'location'
      normlaized_json_obj['type'] = 'location'
      normlaized_json_obj['timestamp'] = Time.at(json_obj[2] / 1000.0)
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


  def write_db(json_obj)
    @logger.debug json_obj
    @rawdata.insert(json_obj)
    
  end

  def read_db()
    @logger.debug @rawdata.find()
  end

end



p = WmsSystemParser.new("../99000204231618_system_file.csv")
p.run()
p.read_db()





