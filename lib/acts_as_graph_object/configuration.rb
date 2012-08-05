module ActsAsGraphObject
  # Configures ActsAsGraphObject.
  def self.configure(configuration = ActsAsGraphObject::Configuration.new)
    yield configuration if block_given?
    @@configuration = configuration
  end
      
  def self.configuration # :nodoc:
    @@configuration ||= ActsAsGraphObject::Configuration.new
  end

  # Can be configured using the ActsAsGraphObject.configure method. For example:
  # 
  # ActsAsGraphObject.configure do |config|
  #   config.namespace = 'my-app'
  # end
  class Configuration
    attr_accessor :namespace, :app_id, :admins

    def initialize # :nodoc:
      # set any defaults in here
    end
    
    # symbolize namespace
    def namespace=(namespace)
      @namespace = namespace.to_sym
    end
  end
end
