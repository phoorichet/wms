class Event
  # attr_accessible :title, :body
  # Event represents raw data that has been collected from mobile devices.
  # It can be devided into 3 types:
  # => 1. wifi accesspoint info
  # => 2. location
  # => 3. sensor
  # => 4. audio

  # Include Mongoid library to map to MongoDB database
  include Mongoid::Document

  # Define Mongodb configurtions
  store_in collection: "events", database: "test", session: "default"

  # Requried fields
  field :timestamp, type: DateTime
  field :user_id,   type: Integer
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
  field :accelerometer_x, type: Float
  field :accelerometer_y, type: Float
  field :accelerometer_z, type: Float
  field :orientation_disabled_x, type: Float
  field :orientation_disabled_y, type: Float
  field :orientation_disabled_z, type: Float
  field :compass_disabled_x, type: Float
  field :compass_disabled_y, type: Float
  field :compass_disabled_z, type: Float
  field :gyro_x, type: Float
  field :gyro_y, type: Float
  field :gyro_z, type: Float
  field :temperature_not_supported, type: Float
  field :light, type: Float

  # Validations
  validates_presence_of :user_id
  validates_presence_of :timestamp
  validates_presence_of :type
  # TODO: device_id is missing for sensor file
  # validates_presence_of :device_id


  # Index
  index({ timestamp: -1 }, { unique: false})
  index({ user_id: 1 }, { unique: false})
  index({ type: 1 }, { unique: false})
  index({ device_id: 1 }, { unique: false})


  # Scopes
  scope :sensor, where(:type => 'sensor')
  scope :wifi, where(:type => 'wifi_accesspoint_info')
  scope :location, where(:type => 'location')
  scope :audio, where(:type => 'audio')

  attr_accessor :start_at, :end_at

  # generate pretty json
  def to_json_pretty
    h = Hash.new
    self.attributes.each do |k,v|
      h[k] = v
    end
    JSON.pretty_generate h
  end

  # Class methods
  def self.get_50events()
  
  end

  # 
  def self.startat(start_at)
    @start_at = start_at
    self
  end

  # 
  def self.endat(end_at)
    @end_at = end_at
    self
  end

  def every_hour

  end
end
