module XmlHelpers
  # @TODO connectors xpath should only be called once
  # Finds all of the target connectors linked to the passed node id
  class << self
    def connectors(xml, node_id)
      xml.xpath('//Connection/Source[@IdRef="' + node_id + '"]').map do |c|
        c.parent.xpath('.//Target').attribute('IdRef').to_s
      end
    end

    # @TODO Make attr param optional
    # attr may be left blank to include the node itself instead
    def xattr(xml, expression, attr)
      node = xml.xpath(expression)

      if node.class == NilClass or node.empty?
        nil
      elsif attr.nil?
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
  end
end