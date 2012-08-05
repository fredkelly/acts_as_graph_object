require "acts_as_graph_object"
require "rails"

module ActsAsGraphObject
  class Railtie < Rails::Railtie
    initializer 'acts_as_graph_object.ar_extensions' do
      ActiveRecord::Base.extend ActsAsGraphObject::Base
    end
    
    initializer 'acts_as_graph_object.view_helpers' do
      ActionView::Base.send :include, ActsAsGraphObject::ViewHelpers
    end
  end
end