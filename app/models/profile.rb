class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :node_parents

  field :name, :type => String
end
