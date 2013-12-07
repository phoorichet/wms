require 'redis'
require 'json'

$redis = Redis.new(:host => '10.0.13.68', :port => 6379, :timeout => 0)

machine_id = "356489052336372"

$redis.subscribe(machine_id) do |on|
  puts "Machine #{machine_id}"
  on.message do |channel, msg|
    puts '[DEBUG]'
    data        = JSON.parse(msg)
    widget_name = data['widget_name']
    device_id   = data['device_id']
    version     = data['widget_version']
    puts "REVC message #{msg}"
    `rails runner script/wms.rb #{device_id} install #{widget_name} #{version}`
  end
end


