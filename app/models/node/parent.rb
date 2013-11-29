class Node::Parent < Node::Base
  include Mongoid::Timestamps

  belongs_to :profile
  has_many :node_children, :class_name => 'Node::Child'
end
