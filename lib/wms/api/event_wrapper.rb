class Wms::Api::EventWrapper

  def initialize(device_id)
    if device_id
      @event = Event.where(devide_id: device_id)
  end

  def 
    
  end
end