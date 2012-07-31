require "acts_as_graph_object"
require "rails"

module ActsAsGraphObject
  class Railtie < Rails::Railtie
    initializer 'acts_as_graph_object.ar_extensions' do |app|
      ActiveRecord::Base.extend ActsAsGraphObject::Base
    end
  end
end