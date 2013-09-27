require 'json'
require 'csv'
require 'logger'
require 'date'
require 'mongo'


class WmsSensorParser
  attr_accessor :csv_file_path, :logger
  #

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
    json_obj = {}
    CSV.foreach( @csv_file_path, {:headers => true,
                                  :header_converters => :symbol}) do |line|
      json_obj['type'] = 'sensor'

      # @logger.debug line
      # @logger.debug 
      write_db(normlaize_json_obj(line))
      total_lines += 1
      if total_lines % 100000 == 0
        @logger.debug total_lines
      end

    end
    @logger.debug "Total line: %d" % total_lines
  end

  def normlaize_json_obj(json_obj)
    normlaized_json_obj = {}
    normlaized_json_obj['type'] = 'sensor'
    normlaized_json_obj['timestamp'] = Time.at(json_obj[0].to_i / 1000.0)
    
    json_hash = json_obj.to_hash
    json_hash.keys.each do |key|
      if key != :timestamp
        normlaized_json_obj[key] = json_hash[key].to_f 
      end 
    end
    
              
    return normlaized_json_obj
  end

  def write_db(json_obj)
    # @logger.debug json_obj
    @rawdata.insert(json_obj)
    
  end

end



p = WmsSensorParser.new('../99000204231618_sensor.csv')
p.run



