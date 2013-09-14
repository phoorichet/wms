class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :username
end
