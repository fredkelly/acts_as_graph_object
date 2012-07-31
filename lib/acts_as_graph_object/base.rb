module ActsAsGraphObject
  module Base
    # standard object properties
    DEFAULT_PROPERTIES = [:title, :type, :image, :url, :description, :site_name,
                          :latitude, :longitude, :street_address, :locality, :region,
                          :postal_code, :country_name, :email, :phone_number, :fax_number]
    
    def acts_as_graph_object(options = {})
      # our property/content pairs
      properties = {}
      
      # try all the default properties first
      DEFAULT_PROPERTIES.each do |property|
        if self.responds_to?(property)
          properties[property] = self.send(property)
        end
      end
      
      # url helpers for fallback url method
      delegate :url_helpers, to: 'Rails.application.routes'
      
      include InstanceMethods
    end
    
    module InstanceMethods
      # requires default_url_options[:host] to be set!
      def url
        url_helpers.send("#{type}_url".downcase, self)
      end
      
      def type
        self.class.name.underscore
      end
    end
  end
end
