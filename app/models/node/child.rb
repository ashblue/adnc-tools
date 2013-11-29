class Node::Child < Node::Base
  belongs_to :node_parent, :class_name => 'Node::Parent'

  # If an attribute other than the inner_text should be returned
  field :return_attr, :type => String

  # Exported JSON attribute name
  field :json_name, :type => String

  # Encapsulate or override the returned value
  field :enforce_type, :type => String

  # Helper methods from xml_helpers
  field :helper, :type => String

  def xattr(xml)
    XmlHelpers.xattr(xml, self.xpath, self.return_attr)
  end

  def connectors(xml)
    XmlHelpers.connectors(xml, self.node_parent.xpath)
  end

  def xpath_sample
    xml = ArticyDraft.last.file_xml
    parent = self.node_parent.result(xml).first
    result = nil

    if parent
      if self.helper == 'xattr'
        result = self.xattr(parent)
      elsif self.helper == 'connectors'
        result = self.connectors(parent)
      end
    end

    if result
      result
    else
      'Invalid xpath'
    end

    #if node
    #
    #  if self.helper == 'xattr'
    #    XmlHelpers.xattr(xml, self.xpath, self.return_attr)
    #  else
    #
    #  end
    #  #node.to_xml
    #else
    #  'Invalid xpath'
    #end
  end
end
