class Node::BaseSerializer < ActiveModel::Serializer
  attributes :id, :xcode
  #
  #def id
  #  object._id.to_s
  #end
end
