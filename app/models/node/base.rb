class Node::Base
  include Mongoid::Document
  field :xpath, type: String

  # Spits out an example xpath node
  def xpath_sample
    xml = ArticyDraft.last.file_xml
    node = xml.xpath(self.xpath).first
    if node
      node.to_xml
    else
      'Invalid xpath'
    end
  end

  def as_json(options = {})
    export = super(options)
    export[:xml] = xpath_sample
    export
  end
end
