class Node::Child < Node::Base
  belongs_to :node_parent, :class_name => 'Node::Parent'

  # If an attribute other than the inner_text should be returned
  field :return_attr, :type => String

  # Exported JSON attribute name
  field :name, :type => String

  # Helper methods from xml_helpers
  field :helper, :type => String
end
