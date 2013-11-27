class Node::Parent < Node::Base
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :node_children
end
