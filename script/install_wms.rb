#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'
require 'open-uri'
require 'net/http'
include FileUtils
require 'open-uri'


#download VirtualBox
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

#go to downloads directory
puts "Installing most recent .dmg"

cd File.expand_path("~/GitHubCode/vm_wms/")
path = Pathname.new('.')

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

mount_point = Pathname.new "~/GitHubCode/vm_wms/"
puts "Mount Point: #{mount_point}\n"
puts "Last DMG: #{last_dmg}\n"

result = `hdiutil attach -mountpoint #{mount_point} #{last_dmg}`
puts "#{result}"

#find any apps in the mounted dmg
   r = `sudo installer -pkg ~/GitHubCode/vm_wms/VirtualBox.pkg -target /` 
   puts "#{r}"

#unmount the .dmg
puts "Unmounting #{last_dmg}"
puts Dir.pwd
Dir.chdir(".")
puts Dir.pwd
# result = `hdiutil detach #{mount_point}/#{last_dmg}`
puts "Finished installing #{last_dmg}"

#delete the .dmg
#rm last_dmg

#Opening VirtualBox 
`open /Applications/VirtualBox.app`

#Installing vagrant gem
 out = `sudo gem install vagrant`
 puts "#{out}"

#Adding lucid64 box
`vagrant box add lucid64 http://files.vagrantup.com/lucid64.box`

`ls -lrt`

# #Create a new git repo
# `git clone https://github.com/phoorichet/wms.git`

# #Change to directory wms
# `cd wms`

# #Start lucid64 box
# `sudo vagrant init lucid64`

# #Up the vagrant box
# `sudo vagrant up`

# #ssh the box
# `sudo vagrant ssh`

# `cd /vagrant`
# `sudo apt-get update`
# `sudo apt-get -f install build-essential zlib1g-dev curl git-core sqlite3 libsqlite3-dev`  --> Y required
# `git clone git://github.com/sstephenson/rbenv.git ~/.rbenv`
# `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile`
# `echo 'eval "$(rbenv init -)"' >> ~/.bash_profile`

# `source ~/.bash_profile`
# `git clone git://github.com/sstephenson/ruby-build.git`
# `cd ruby-build/`
# `sudo ./install.sh`

# # `rbenv install 1.9.2-p290`
# # `rbenv rehash`
# # `rbenv global 1.9.2-p290`
# `curl -L https://get.rvm.io | bash -s stable --ruby`
# `source /home/vagrant/.rvm/scripts/rvm`
# `rbenv rehash`

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