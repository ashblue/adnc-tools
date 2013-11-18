module XmlHelpers
  # @TODO connectors xpath should only be called once
  # Finds all of the target connectors linked to the passed node id
  class << self
    def connectors(xml, node_id)
      xml.xpath('//Connection/Source[@IdRef="' + node_id + '"]').map do |c|
        c.parent.xpath('.//Target').attribute('IdRef').to_s
      end
    end
  end
end