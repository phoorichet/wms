require 'wms/namespace'
require 'wms/parser/base'
require 'csv'

class Wms::Parser::Csv #< Wms::Parser::Base
  attr_accessor :csv_file_path, :logger
  #
  def initialize(csv_file_path)
    # super
    @csv_file_path = csv_file_path
    @logger = Logger.new(STDOUT)
  end

  def run
    # adding options to make data manipulation easy
    total_lines = 0
    CSV.foreach( @csv_file_path, {:headers => true,
                                  :header_converters => :symbol}) do |line|

      @logger.debug line
      total_lines += 1
    end
    @logger.debug "Total line: %d" % total_lines
  end

end
