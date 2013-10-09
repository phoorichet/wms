require "wms/parser/csv"

class Storage < ActiveRecord::Base
  # attr_accessible :title, :body
  
  # Create a many relationship to User model
  belongs_to :user

  # PT:: paperclip attr_accessible
  attr_accessible :rawlog, :storage_type, :status, :options

  attr_reader :storage_type_options, :status_options
  # Enable Paperclip
  has_attached_file :rawlog

  # Aaviable types for storage_type.
  # This will use for from validation.
  self.storage_type_options = ["wifi", "location", "sensor", "audio"]
  self.status_options = ["uploaded", "parsed"]
  self.status_default = "uploaded"

  # Validation
  validates :rawlog, :attachment_presence => true
  validates :storage_type, :presence=> true
  validates :storage_type, :inclusion => { in:  @storage_type_options }
  validates :status, :presence=> true
  validates :status, :inclusion => { in:  @status_options }

  # Calll defaults after an instance get initialized
  after_initialize :set_defaults

  # Set the default values
  def set_defaults
    # Set status to default value
    self.status = status_default

    # Initialize options
    self.make_options
  end

  # Create options necessary for readin, parsing, storing
  # @params:
  # @return:
  #
  def make_options
    self.options = {}
    self.options.storage_type = @storage_type
    
  end

  # This method choose the parser type based on storage type configuration
  # @params:
  # @return: parser class
  #
  def select_parser
    
  end


  # This method will read the file from storage, parse the file, store the file
  # in the database.
  #
  # @params:
  # @return: 
  #
  # Right now, MongoDB is used as main repository.
  def process
    logger.debug "Reading stoage file from: %{self.rawlog.path}"

    # Check if the path exists
    begin
      # logger.debug "Call parser %{}"
      # TODO:: Make the parser configurable so that we can easily define more
      # parser with modifying lines of code
      parser = Wms::Parser::Csv.new(self.rawlog.path, @options)

      # The parser has to return true to notify that the parsing process is
      # succesful. The storage status then should be changed according to 
      # the parsing result.
      if parser.run
        # Change status when the file is parsed successfully
      else
        logger.error "The wms parser failed to parse the file %{self.rawlog.path}"
      end

    rescue Exception => e
      logger.error "ERROR: [%{e}]"
    end
    
  end # end parse method




end
