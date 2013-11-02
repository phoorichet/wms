module Wms::Api::Event
  
  private
  attr_accessor :events

  def self.included(base)
    base.extend(Wms::Api::Event::ClassMethod)
  end

  def events(&block, device_id)
    self.events = Event.where(device_id: device_id)
    events_hash = []
    events.each do |event|
      events_hash.push(event.to_hash)
    end
    callback = block
    block.call(events_hash)
  end

  module ClassMethod

  end
end
