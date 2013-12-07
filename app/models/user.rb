class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :device_id
  # attr_accessible :title, :body
  
  # PT:: A mapping to storage
  has_many :storages

  has_many :widgets

  # Add events method as a getter because Event class is not inherited from ActiveRecord
  def events
    Event.where(:user_id => self.id).order_by(:timestamp => -1)
  end

  def find_by_device_id(device_id)
    User.where(:device_id => device_id).first
  end

  def analytics
    Analytic.where(:user_id => self.id)
  end
end
