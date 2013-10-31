module Wms::Api::Event
  
  private
  attr_accessor :event

  def self.included(base)
    base.extend(Wms::Api::Event::ClassMethod)
  end

  def events
    self.event.first
  end

  module ClassMethod

  end
end
