module Wms::Api::Event
  
  #private
  #attr_accessor :event

  def self.included(base)
    base.extend(Wms::Api::Event::ClassMethod)
  end

  def events(&block)
    Event.all.each do |d|
      block.call(d.attributes)
    end
  end

  module ClassMethod

  end
end
