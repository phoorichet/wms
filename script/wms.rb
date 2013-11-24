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
  end
end


user = User.find(ARGV[0].to_i)
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

