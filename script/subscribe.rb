require 'redis'
require 'json'

$redis = Redis.new(:host => 'localhost', :port => 6379, :timeout => 0)


$redis.subscribe('test') do |on|
  on.message do |channel, msg|
    puts '[DEBUG]'
    data = JSON.parse(msg)
    puts data['widget_name']
    puts data['device_id']
    puts data['widget_version']
  end
end

