class Storage < ActiveRecord::Base
  # attr_accessible :title, :body
  
  # Create a many relationship to User model
  belongs_to :user

  # PT:: paperclip attr_accessible
  attr_accessible :rawlog
  has_attached_file :rawlog

  # Validation
  validates :rawlog, :attachment_presence => true

end
