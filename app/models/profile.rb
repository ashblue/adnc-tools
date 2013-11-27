class Profile
  include Mongoid::Document

  belongs_to :file_name
  has_many :node_parents, :class_name => 'Node::Parent'

  field :name, type: String
  validates_presence_of :name
end
