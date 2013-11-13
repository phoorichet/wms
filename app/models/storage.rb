require 'wms/input/android_sensor'
require 'wms/input/android_wifilocation'

class Storage < ActiveRecord::Base
  # attr_accessible :title, :body
  
  # Create a many relationship to User model
  belongs_to :user

  # PT:: paperclip attr_accessible
  attr_accessible :rawlog, :storage_type, :status, :last_parsed_line, :count_success, :count_failure

  # attr_accessor :options
  # attr_reader :storage_type_options, :status_options, :status_default
  
  # Enable Paperclip
  has_attached_file :rawlog

  # Aaviable types for storage_type.
  # This will use for from validation.

  STORAGE_TYPE = ["wifilocation", "sensor", "audio"]

  # Validation
  validates :rawlog, :attachment_presence => true
  validates :storage_type, :presence=> true
  validates :storage_type, :inclusion => { in:  ["wifilocation", "sensor", "audio"] }
  validates :status, :presence=> true
  validates :status, :inclusion => { in:  ["uploaded", "parsed", "finished"] }


  # Calll defaults after an instance get initialized
  after_initialize :set_defaults

  # Set the default values
  def set_defaults
    puts 'call set_defaults!'
    # Set status to default value
    self.status ||= "uploaded"
    self.last_parsed_line ||= 0

  end

  # Create options necessary for readin, parsing, storing
  # @params:
  # @return:
  #
  def make_options
    options = Hash.new
    options[:storage_type] = self.storage_type
    options[:filepath] = self.rawlog.path
    
    options
  end

  def test_type
    puts STORAGE_TYPE
  end


  # This method will read the file from storage, parse the file, store the file
  # in the database.
  #
  # @params:
  # @return: 
  #
  # Right now, MongoDB is used as main repository.
  def parse
    logger.debug "Reading stoage file from: #{self.rawlog.path}"
    if self.status != 'finished'
      last_parsed_line = self.last_parsed_line
      # make_options
      begin
        # Match the proper parser and build options
        case self.storage_type
        when "wifilocation"
          @parser = Wms::Input::AndroidWifiLocation
        when "sensor"
          @parser = Wms::Input::AndroidSensor
        when "audio"
          raise "Not Supported yet storage type #{storage_type}"
        else
          raise "Undefined storage type #{storage_type}"
        end

        @processor = @parser.new
        options = make_options
        @processor.register(options=options)

        @processor.run do |data|
          begin
            create_event data
            
          rescue Exception => e
            logger.error "ERROR #{self.class.name}: #{e} for #{data}"
          end
          last_parsed_line += 1
        end

        
        self.last_parsed_line = last_parsed_line
        self.status = "finished"
        self.save
        
      rescue Exception => e
        logger.error "ERROR: [#{e}]"
        self.last_parsed_line = last_parsed_line
        self.status = "error"
        self.save
      end # end begin
    
    end #end if self.status != 'finished'


    
    
  end # end parse method

  # Create an event an update it into database
  # @data: a hash of raw data
  def create_event(doc)
    attach_user_id doc
    attach_storage_id doc
    new_event = Event.new(doc)
    new_event.save!
  end


  # This method will insert the attribute "user_id" to the document
  def attach_user_id(doc)
    doc["user_id"] = self.user.id
  end

  def attach_storage_id(doc)
    doc["storage_id"] = self.id
  end

  # Delete an event
  def delete_event(event)
    event.delete
  end

  # Delete all events that are correlated with this user.
  def delete_all_events
    doc = {}
    attach_user_id doc
    attach_storage_id doc

    Event.delete_all(doc)
  end

  # Search operations
  def find(doc)
    attach_user_id doc
    attach_storage_id doc
    Event.where(doc)
  end




end
