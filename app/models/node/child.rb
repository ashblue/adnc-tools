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

  field :xpath_alt, :type => String

  # @TODO Horrible way of calling these, must be a cleaner way to do this
  def xattr(node)
    XmlHelpers.xattr(node, self.xpath, self.return_attr)
  rescue
    nil
  end

  def xattr_array(node)
    XmlHelpers.xattr_array(node, self.xpath, self.return_attr)
  rescue
    nil
  end

  def image_path(xml, node)
    id = self.xattr(node)
    XmlHelpers.image_path(xml, id)
  rescue
    nil
  end

  def connectors(xml, node)
    XmlHelpers.connectors(xml, node['Id'])
  rescue
    nil
  end

  def enumeration_property_definition(xml, node)
    XmlHelpers.enumeration_property_definition(xml, self.xpath_alt, self.xattr(node))
  rescue
    nil
  end

  # #TODO Make sample and result use same logic
  def result(xml, parent)
    if self.helper == 'xattr'
      result = self.xattr(parent)
    elsif self.helper == 'xattr_array'
      result = self.xattr_array(parent)
    elsif self.helper == 'image_path'
      result = self.image_path(xml, parent)
    elsif self.helper == 'connectors'
      result = self.connectors(xml, parent)
    elsif self.helper == 'enumeration_property_definition'
      result = self.enumeration_property_definition(xml, parent)
    end

    if self.enforce_type == 'array'
      [result]
    elsif self.enforce_type == 'boolean'
      result == '1' ? true : false
    else
      result
    end
  end

  def xpath_sample
    xml = ArticyDraft.last.file_xml
    parent = xml.xpath(self.node_parent.xpath).first
    result = nil

    if parent
      if self.helper == 'xattr'
        result = self.xattr(parent)
      elsif self.helper == 'xattr_array'
        result = self.xattr_array(parent)
      elsif self.helper == 'image_path'
        result = self.image_path(xml, parent)
      elsif self.helper == 'connectors'
        result = self.connectors(xml, parent)
      elsif self.helper == 'enumeration_property_definition'
        result = self.enumeration_property_definition(xml, parent)
      end
    end

    if result
      if self.enforce_type == 'array'
        [result]
      elsif self.enforce_type == 'boolean'
        result == '1' ? true : false
      else
        result
      end
    else
      'Invalid xpath'
    end
  end
end
