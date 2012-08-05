%W(configuration base helpers railite version).each do |file|
  require "acts_as_graph_object/#{file}"
end