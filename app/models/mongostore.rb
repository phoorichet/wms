class MongoStore
  include MongoMapper::Document
  attr_accessible :name

  key :type, String
  key :timestamp, String
end