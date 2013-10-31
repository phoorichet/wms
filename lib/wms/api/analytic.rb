module Wms::Api::Analytic
  private
  attr_accessor :analytic

  def self.included(base)
    @analytic = Analytic

    base.extend(Wms::Api::Analytic::Classmethod)
  end

  def analytic
    self
  end

  module ClassMethod

  end
end
