require "wms/parser/csv"

class Storage < ActiveRecord::Base
  # attr_accessible :title, :body
  
  # Create a many relationship to User model
  belongs_to :user

  # PT:: paperclip attr_accessible
  attr_accessible :rawlog, :storage_type
  has_attached_file :rawlog

  # Validation
  validates :rawlog, :attachment_presence => true

  # PT:: Read, parse file
  def parse
    logger.info "-----------------Parser-----------------"
    logger.info self.rawlog.path

    parser = Wms::Parser::Csv.new(self.rawlog.path)
    parser.run
  end




end
