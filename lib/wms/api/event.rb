require 'active_support/concern'

module Wms::Api::Event
  extend ActiveSupport::Concern

  attr_accessor :options

  private
  attr_accessor :events

  def set_options(options={})
    self.options = options
  end

  def events(&block)
    events = Event.all_in(type: options[:type]).between(timestamp: options[:begin]..options[:end])
    events_hash = []
    if events.length > 0
      events.each do |e|
        events_hash.push(e.as_document)
      end
    end
    
    events_hash
    
  end

  module ClassMethod

  end

end
