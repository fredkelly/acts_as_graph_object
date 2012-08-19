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
        # standard object properties & alternative names
        default_properties = {
          :title           => [:name, :label],
          :type            => [:kind, :group, :class],
          :image           => [:picture, :photo],
          :url             => [:permalink, :link],
          :description     => [:info, :details],
          :site_name       => [:site],
          :latitude        => [:lat],
          :longitude       => [:long],
          :street_address  => [:address],
          :locality        => [:locale, :area],
          :region          => [:province, :territory],
          :postal_code     => [:zip_code, :zip],
          :country_name    => [:country],
          :email           => [:email_address],
          :phone_number    => [:phone],
          :fax_number      => [:fax]
        }

        # property/content pairs
        # we build this up to contain our final values
        properties = {
          :og => {},
          :fb => {
            :app_id => configuration.app_id,
            :admins => configuration.admins.join(',')
          }
        }
            
        # try all the default og properties first
        default_properties.each do |property_name, alternatives|
          ([property_name] + alternatives).each do |property|
            if self.respond_to?(property)
              properties[:og][property_name] = self.send(property)
            end
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
