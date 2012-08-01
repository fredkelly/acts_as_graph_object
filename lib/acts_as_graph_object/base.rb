module ActsAsGraphObject
  module Base
    # standard object properties
    DEFAULT_PROPERTIES = [:title, :type, :image, :url, :description, :site_name,
                          :latitude, :longitude, :street_address, :locality, :region,
                          :postal_code, :country_name, :email, :phone_number, :fax_number]
    
    def acts_as_graph_object(options = {})   
      # url helpers for fallback url method
      delegate :url_helpers, to: 'Rails.application.routes'
      delegate :configuration, to: 'ActsAsGraphObject'
      
      include InstanceMethods
         
      # our property/content pairs
      @properties = {}
      
      # try all the default og properties first
      DEFAULT_PROPERTIES.each do |property|
        if self.respond_to?(property)
          @properties[:og][property] = self.send(property)
        end
      end
      
      puts title
      
      # add any custom properties
      options[:custom].each do |property|
        @properties[configuration.namespace.to_sym][property] = self.send(property)
      end
    end
    
    module InstanceMethods
      # requires default_url_options[:host] to be set!
      def url
        url_helpers.send("#{self.class}_url".downcase, self)
      end
      
      def type
        [configuration.namespace, self.class.name.underscore].join(':')
      end
    end
  end
end
