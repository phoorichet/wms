module Wms::Api::Event
  
  private
  attr_accessor :event

  def self.included(base)
    @event = Event
    
    base.extend(Wms::Api::Event::ClassMethod)
  end

  def events
    self
  end

  module ClassMethod

  end
end
