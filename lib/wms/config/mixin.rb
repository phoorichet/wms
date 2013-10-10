module Wms::Config::Mixin
  # Adapted from http://speakmy.name/2011/05/29/simple-configuration-for-ruby-apps/
  # config for an instance
  attr_accessor :config

  # This method is called when someone does 'include Wms::Config::Mixin'
  def self.included(base)
    # Add all methods in MixinClassMethod as Class method.
    # When Mixin is included, the user can call:
    # => Mixin.list_mixins
    base.extend(Wms::Config::Mixin::MixinClassMethod)
  end

  def config_init(params)
    @config ||= Hash.new
    params.each do |key, value|
      @config[key] = value
    end
  end

  

  # def method_missing(name, *args, &block)
  #   @config[name.to_sym] ||
  #   fail(NoMethodError, "unknown configuration root #{name}", caller)
  # end


  # This inner module is defined for class method
  module MixinClassMethod

    # Define a new configuration setting
    def config(name, opts={})
      @config ||= Hash.new

      name = name.to_s unless name.is_a?(Symbol)
      @config[name] = opts  # ok if this is empty

    end # def config

    def default(name, value)
      @defaults ||= Hash.new
      @defaults[name.to_s] = value
    end

    # return config
    def get_config
      @config
    end

    # return default value given name
    def get_default(name)
      key_name = if name.is_a?(Symbol) then name  else name.to_s end
      puts ">>>>>>>>>>>>>#{@config}}"
      @config[key_name][:default]
    end

    # return default value given name
    def set_default(value)
      key_name = if name.is_a?(Symbol) then name  else name.to_s end
      @config[key_name][:default] = value
    end

    # return a hash of key => default derived from config
    def get_defaults
      defaults = Hash.new
      @config.each do |key, value|
        defaults[key] = value[:default]
      end
      defaults
    end

    # This is the main point of entry - we call Settings.load! and provide
    # a name of the file to read as it's argument. We can also pass in some
    # options, but at the moment it's being used to allow per-environment
    # overrides in Rails
    # 
    # Example 
    # Load without environment
    # => Settings.load!("config/appdata/example.yml")
    #
    # Load with environment
    # => Settings.load!(
    #       "#{Rails.root}/config/appdata/env-example.yml",
    #       :env => Rails.env)
    def source(filename, options={})
      newsets = YAML::load_file(filename).deep_symbolize_keys
      newsets = newsets[options[:env].to_sym] if \
                                                 options[:env] && \
                                                 newsets[options[:env].to_sym]
      @config ||= Hash.new
      deep_merge!(@config, newsets)
    end

    # Deep merging of hashes
    # deep_merge by Stefan Rusterholz, see http://www.ruby-forum.com/topic/142809
    def deep_merge!(target, data)
      merger = proc{|key, v1, v2|
        Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
      target.merge! data, &merger
    end
      
    
  end # end MixinClassMethod

end