class MobileController < ApplicationController

  def new
    @user = User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @storage }
    end

  end

  # POST /mobiles/registration
  #
  # Get devices id and create a user object
  def register
  
  end

end

