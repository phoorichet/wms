class DataRecord
  # DataRecrod represents raw data that has been collected from mobile devices.
  # It can be devided into 3 types:
  # => 1. wifi accesspoint info
  # => 2. location
  # => 3. sensor
  # => 4. audio

  # Include Mongoid library to map to MongoDB database
  include Mongoid::Document

  # Define Mongodb configurtions
  store_in collection: "rawdata", database: "wms_dev", session: "default"

  # Requried fields
  field :user_id,   type: Integer
  field :timestamp, type: DateTime
  field :type,      type: String
  field :device_id, type: String
  
  # Optional fields
  # 1. wifi
  field :wifi_list, type: Array
  # 2. location
  field :longitude, type: Float
  field :latitude,  type: Float
  field :speed,     type: Float
  field :has_speed, type: Boolean
  field :altitude,  type: Float
  field :has_altitude, type: Boolean
  field :bearing,   type: Float
  field :has_bearing, type: Boolean
  field :accuracy,  type: Float
  field :sattlelites, type: Integer
  # 3. sensor
  field :Accelerometer X,
  field :Accelerometer Y,
  field :Accelerometer Z,
  field :Orientation Disabled,
  field :Orientation Disabled,
  field :Orientation Disabled,
  field :Compass Disabled,
  field :Compass Disabled,
  field :Compass Disabled,
  field :Gyro X,
  field :Gyro Y,
  field :Gyro Z,
  field :Temperature Not Supported,
  field :Light

  # Validations
  validates_presence_of :user_id
  validates_presence_of :timestamp
  validates_presence_of :type
  validates_presence_of :device_id


end
