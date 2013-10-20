module Widget: Apiset
def create
#creating a record dynamically on the fly
end


def fetch(model, tstamp, deviceID, feature)
     #going to evolve 
     #feature : specific field like lattitude, etc 
     @record =  model.where(timestamp: tstamp, deviceID: deviceID, feature: feature)	
     return @record
end


