require 'wms/widget/base'

class Wms::Widget::Widget1 < Wms::Widget::Base
  def initialize
    puts "Init widget1"
  end

  def self.register(option={})
  
  end

  def self.run
    # Call api
    puts "Run..." 

  end

  def save(data)
    self.save_anaytics(data)
  end

end

