module ActsAsGraphObject
  module Base
    # standard object properties
    DEFAULT_PROPERTIES = ["title", "type", "image", "url", "description", "site_name",
                          "latitude", "longitude", "street_address", "locality", "region",
                          "postal_code", "country_name", "email", "phone_number", "fax_number"]
    
    def acts_as_graph_object
      include InstanceMethods
    end
    
    module InstanceMethods
      def url
        Rails.application.routes.url_helpers.url_for(self)
      end
    end
  end
end
