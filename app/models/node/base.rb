class Node::Base
  include Mongoid::Document
  field :xpath, type: String

  def as_json(options = {})
    export = super(options)
    export[:xml] = xpath_sample
    export
  end
end
