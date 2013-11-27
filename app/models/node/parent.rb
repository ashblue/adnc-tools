class Node::Parent < Node::Base
  include Mongoid::Timestamps

  has_many :node_children, :class_name => 'Node::Child'
end
