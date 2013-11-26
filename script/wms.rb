puts '----------- WMS ----------'

def usage
  puts 'Usage wms user_id install gemname [version]'
end

def install_gem(user, name, opt={})
  puts "  ==> Installing...#{name} #{opt[:version]}"
  if opt[:version]
    result = `gem install #{name} -v #{opt[:version]}`
  else
    result  = `gem install #{name}` 
  end

  # puts result

  if result.include? "Successfully installed #{name}"
    version = result.split "Successfully installed #{name}-"
    version = version[1].split /\n/
    version = version[0]
    puts "  ==> #{name} (#{version}) installed"
    puts "  ==> Creating... a widget"
    klass = "#{name}".gsub('-', '/').camelize + "::Main"
    widget =  user.widgets.where(:name => name).first
    if widget
      widget.version = version
      widget.class_name = klass
      widget.save
    else
      user.widgets.create(:name => name, :version => version, :class_name => klass)
    end

    puts widget

    lines = []
    # Modify Gemfile
    File.open('Gemfile', 'r').each_line do |line|
      lines << line
      # if line.include? "#{name}"
      #   puts "  ==> Found #{name}"
      # end
    end

    count = 0
    found_gem = false
    gemfile_modified = false
    lines.each do |line|
      # puts "  ==> [#{count}]: #{line}"
      if line.include? "#{name}"
        found_gem = true
        puts "  ===> Found #{line}"
        line_split = line.split(',')
        if line_split.size > 1
          gem_version = line_split[1]
          puts "  ===> Gemversion is #{gem_version} vs '~> #{version}'"
          if gem_version.strip != "'~> #{version}'"
            new_line = "gem '#{name}', '~> #{version}'"
            lines[count] = new_line
            puts "  ==> Update gem version to #{new_line}"
            gemfile_modified = true
          end
        end
      end
      count += 1
    end

    # install the new gem
    if !found_gem
      lines << "\ngem '#{name}', '~> #{version}'"
      gemfile_modified = true
    end


    if gemfile_modified
      puts "  ==> Updating Gemfile...
    "
      # Write the lines back to Gemfile
      begin
        file = File.open("Gemfile", "w")
        lines.each do |line|
          file.write(line) 
        end
      rescue IOError => e
        #some error occur, dir not writable etc.
      ensure
        file.close unless file == nil
      end
    end

    # Restart Rails server
    # TBD
    rails_pid = `pgrep -f "rails s"`.split(/\n/).first.to_i
    Process.kill(9, rails_pid)

    # run bundle install
    `bundle install`
    puts "Complete bundle install..."

  end
end


user = User.find_by_device_id(ARGV[0])
puts user
if user
  case ARGV[1]
  when "install"
    gemname = ARGV[2]
    version = ARGV[3] 
    install_gem(user, gemname, :version => version)
  else
    usage
  end
else
  usage
end

