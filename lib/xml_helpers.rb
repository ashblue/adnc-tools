module XmlHelpers
  # @TODO connectors xpath should only be called once
  # Finds all of the target connectors linked to the passed node id
  class << self
    def connectors(xml, node_id)
      xml.xpath('//Connection/Source[@IdRef="' + node_id + '"]').map do |c|
        c.parent.xpath('.//Target').attribute('IdRef').to_s
      end
    end

    def image_path(xml, id)
      xml.xpath('//Asset[@Id="' + id + '"]//AssetFilename').inner_text
    end

    # @TODO Make attr param optional
    # attr may be left blank to include the node itself instead
    def xattr(xml, expression, attr = nil)
      node = xml.xpath(expression)

      if node.class == NilClass or node.empty?
        nil
      elsif attr.nil? or attr == ''
        node.inner_text
      else
        result = node.attribute(attr).to_s
        if result != '0x0000000000000000'
          result
        else
          nil
        end
      end
    end

    def xattr_array(xml, expression, attr = nil)
      xml.xpath(expression).map do |n|
        if attr.nil? or attr == ''
          n.inner_text
        else
          result = n.attribute(attr).to_s
          if result != '0x0000000000000000'
            result
          else
            nil
          end
        end
      end
    end
  end
end