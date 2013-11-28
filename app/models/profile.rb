class Profile
  include Mongoid::Document

  belongs_to :file_name
  has_one :node_parent, :class_name => 'Node::Parent'

  field :name, type: String
  validates_presence_of :name
end
