class Node::Base
  include Mongoid::Document

  # Literal xpath query string
  field :xpath, :type => String
end
