class Analytic < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :timestamp, :accelerometer_x, :accelerometer_y
  
  # Include Elasticseatch Mixin
  include Tire::Model::Search
  include Tire::Model::Callbacks
end
