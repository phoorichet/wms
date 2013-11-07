class Analytic
  include Mongoid::Document
  field :user_id, type: Integer
  field :widget_id, type: Integer

  # generate pretty json
  def to_json_pretty
    h = Hash.new
    self.attributes.each do |k,v|
      h[k] = v
    end
    JSON.pretty_generate h
  end 
end
