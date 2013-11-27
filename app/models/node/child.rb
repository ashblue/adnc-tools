class Node::Child < Node::Base
  include Mongoid::Document

  has_one :node_parent

  # If an attribute other than the inner_text should be returned
  field :return_attr, :type => String

  # Exported JSON attribute name
  field :name, :type => String

  # Helper methods from xml_helpers
  field :helper, :type => String
end
