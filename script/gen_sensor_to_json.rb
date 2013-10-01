require 'json'
require 'csv'
require 'logger'
require 'date'
require 'mongo'
require 'active_support/all'

class WmsSensorParser
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

    @current_time = Time.now
  end # end initialize

  def run(num_record)
    # adding options to make data manipulation easy
    total_lines = 0
    json_obj = {}
    while total_lines < num_record

      CSV.foreach( @csv_file_path, {:headers => true,
                                    :header_converters => :symbol}) do |line|
        
      norm_json = self.normlaize_json_obj(line, total_lines)
      # @logger.debug norm_json
      self.write_db(norm_json)
      total_lines += 1

      if num_record == total_lines
        break
        @logger.debug total_lines
      end

      end

    end
    @logger.debug "Total line: %d" % total_lines
  end

  def normlaize_json_obj(json_obj,index)
    normlaized_json_obj = {}
    normlaized_json_obj['type'] = 'sensor'
    normlaized_json_obj['timestamp'] =  @current_time.advance(:seconds => index)
    
    json_hash = json_obj.to_hash
    # @logger.debug json_hash
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

  def read_db()
    @logger.debug @rawdata.find()
  end
end # end class

p = WmsSensorParser.new('../99000204231618_sensor.csv')
p.run(1000000)
# p.read_db()