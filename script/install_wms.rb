#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'
require 'open-uri'
require 'net/http'
include FileUtils
require 'open-uri'

# Dir.mkdir(File.join(Dir.home, "/VirtualBox/"), 0777)
cd File.expand_path("~/VirtualBox/")
path = Pathname.new('.')

# #download VirtualBox
# Net::HTTP.start("dlc.sun.com.edgesuite.net") do |http|
#   begin
#     file = open("VirtualBox-4.2.18-88780-OSX.dmg", 'wb')
#     http.request_get('/' + URI.encode("virtualbox/4.2.18/VirtualBox-4.2.18-88780-OSX.dmg")) do |response|
#       response.read_body do |segment|
#         file.write(segment)
#       end
#     end
#   ensure    
#   end
# end

# puts `ls -lrt`

puts "Installing most recent .dmg"
#find most recent .dmg file
files = path.entries.collect { |file| path+file }.sort { |file1,file2| file1.ctime <=> file2.ctime }
files.reject! { |file| ((file.file? and file.to_s.include?(".dmg")) ? false : true) }
last_dmg = files.last

# puts "#{last_dmg}"

#if there is no .dmg file then reject this.
if !last_dmg
  puts "No DMG files" 
  exit
end

puts "Mounting #{last_dmg}"

mount_point = Pathname.new "~/VirtualBox/"
puts "Mount Point: #{mount_point}\n"
puts "Last DMG: #{last_dmg}\n"

puts `hdiutil attach -mountpoint #{mount_point} #{last_dmg}`


#find any apps in the mounted dmg
puts `sudo installer -pkg ~/VirtualBox/VirtualBox.pkg -target /`
   

#unmount the .dmg
puts "Unmounting #{last_dmg}"
puts `hdiutil detach #{mount_point}/#{last_dmg}`
puts "Finished installing #{last_dmg}"



# delete the .dmg
Dir.chdir(".")
puts `sudo rm -rf ~/VirtualBox/`

#go to downloads directory
puts Dir.pwd
Dir.chdir(".")
Dir.mkdir(File.join(Dir.home, "/cisco-ini-project/"), 0777)
cd File.expand_path("~/cisco-ini-project/")
path = Pathname.new('.')

#Opening VirtualBox 
open_VB = `open /Applications/VirtualBox.app`
puts "#{open_VB}"

# #Create a new git repo
create_repo = `git clone https://github.com/phoorichet/wms.git`
puts "#{create_repo}"

# #Change to directory wms
goto_wms = Dir.chdir("wms/")
Dir.mkdir(File.join(Dir.home, "/cisco-ini-project/data"), 0777)

puts "Into wms now!"
puts `ls -lrt`


#Installing vagrant gem
puts `gem install vagrant`

#Removing relevant vagrant file
`sudo rm -f Vagrantfile`

# Adding package box
# add_box = `vagrant box add lucid64 http://files.vagrantup.com/lucid64.box`
# puts "#{add_box}"

#Start package box
puts `sudo vagrant init ~/package`
puts `sudo cp ~/GitHubCode/Vagrantfile ~/cisco-ini-project/wms/Vagrantfile`

puts "Up the vagrant box"
puts `sudo vagrant up`

puts "ssh the box"
# ssh_vag = `sudo vagrant ssh -c "rm -f test test1"`
# puts "#{ssh_vag}"

# `cd /vagrant`
# `sudo gem install bundler`

# `bundle`

# #sudo apt-get install vim  --> Y required
# #Add in Gemfile 
# #gem 'therubyracer'
# `bundle`

# `bundle exec rails s`

# # know your ip address
# # curl ifconfig.me