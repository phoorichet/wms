require 'active_support/concern'

module Wms::Api::Event
  # Looks for ClassMethods to be included
  extend ActiveSupport::Concern

  attr_accessor :options

  #private
  attr_accessor :events
 
  # Get called when included
  included do
    # Nothing to include for now
    init
    puts "Init event...\n\n"
  end

  def initialize
    super
    @events = Event
  end


  def set_options(options={})
    self.options = options
  end


  def event(&block)
    events = Event.all_in(type: options[:type]).between(timestamp: options[:begin]..options[:end])
    events_hash = []
    if events.length > 0
      events.each do |e|
        events_hash.push(e.as_document)
      end
    end
    
    events_hash
    
  end

  module ClassMethods
        
    def init
    end

  end

end
