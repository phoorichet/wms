require 'wms/widget/base'

class Wms::Widget::Widget1 < Wms::Widget::Base
  def initialize
    super
    puts "Init widget1"
  end

  # @override
  def register(option={})
  
  end

  # @override 
  def run
    # Call api
    puts "Run..." 
    puts 
    event = self.events

    event.limit(10).each do |e| 
      puts e.to_json
      e.delete("_id")
      a = self.analytic.new(e.attributes)
      a.save
    end
    puts 

    #puts event.accelerometer_x = 1.0
    #event.save
    #puts @events.first.to_json

  end

  def save(data)
    self.save_anaytics(data)
  end

end

