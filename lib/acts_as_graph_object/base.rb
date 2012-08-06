module ActsAsGraphObject
  module Base
    def acts_as_graph_object(options = {})   
      # url helpers for fallback url method
      delegate :url_helpers, to: 'Rails.application.routes'
      delegate :configuration, to: 'ActsAsGraphObject'
      
      class_attribute :options
      self.options = options
      
      include InstanceMethods
    end
    
    module InstanceMethods
      # requires routes.default_url_options[:host] to be set!
      # TODO: add warning message if method is called?
      def url
        url_helpers.send("#{self.class}_url".downcase, self) rescue nil
      end
      
      def type
        [configuration.namespace, self.class.name.underscore].join(':')
      end
      
      def graph_properties
        # standard object properties
        default_properties = [:title, :type, :image, :url, :description, :site_name,
                              :latitude, :longitude, :street_address, :locality, :region,
                              :postal_code, :country_name, :email, :phone_number, :fax_number]
      
        # property/content pairs
        properties = {
          :og => {},
          :fb => {
            :app_id => configuration.app_id,
            :admins => configuration.admins.join(',')
          }
        }
            
        # try all the default og properties first
        default_properties.each do |property|
          if self.respond_to?(property)
            properties[:og][property] = self.send(property)
          end
        end
            
        # add any custom properties..
        properties[configuration.namespace] ||= {} unless options[:custom].nil?
        Array(options[:custom]).each do |property|
          properties[configuration.namespace][property] = self.send(property)
        end
        
        properties
      end
    end
  end
end
