class Project
  include MongoMapper::Document
  attr_accessible :name


  key :name, String, :required => true
  key :priority, Integer
end
