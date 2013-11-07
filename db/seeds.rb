# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

# Get the first user
user = User.first


# Remove all existing widget first.
Widget.all.each { |widget| widget.delete }

widget1  = Widget.create({
  :id => 1,
  :name => "Widget1",
  :description => "The first widget ever created.",
  :version => "0.0.1",
  :config_file_path => "widget/widget1",
  :is_disable => false,
  :user_id => user.id
})

location_widget  = Widget.create({
  :id => 2,
  :name => "LocationWidget",
  :description => "Find time spent from one page to another",
  :version => "0.0.1",
  :config_file_path => "widget/locationwidget",
  :is_disable => false,
  :user_id => user.id
})

wifi_widget  = Widget.create({
  :id => 3,
  :name => "WifiWidget",
  :description => "Find distint wifi list on 1-hour windows",
  :version => "0.0.1",
  :config_file_path => "widget/wifiwidget",
  :is_disable => false,
  :user_id => user.id
})


