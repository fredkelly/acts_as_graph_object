module ActsAsGraphObject
  module ViewHelpers
    def graph_object_tags_for(object, overrides = {})
      raise "You need to add acts_as_graph_object to your #{object.class} model." unless object.respond_to?(:graph_properties)
      meta_tags = []
      # go through each namespace: :fb, :og & custom..
      object.graph_properties.deep_merge(:og => overrides).each do |namespace, attributes|
        attributes.each do |property, values|
          # in most cases 'values' will be a single value
          Array(values).each do |content|
            meta_tags << tag(:meta, :property => [namespace, property].join(':'), :content => content)
          end
        end
      end
      meta_tags.join("\n").html_safe
    end
  end
end
