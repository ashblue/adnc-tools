class Node::Parent < Node::Base
  include Mongoid::Timestamps

  belongs_to :profile
  has_many :node_children, :class_name => 'Node::Child'

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

  def result(xml)
    h_export = {}
    @profile = self.profile
    type = @profile.name
    template = @profile.template

    xml.xpath(self.xpath).each do |p|
      h_export[p['Id']] = {}
      h_export[p['Id']][:type] = type.downcase if !type.nil?
      h_export[p['Id']][:template] = template.downcase if !template.nil?

      # for each node loop through all children with result
      self.node_children.each do |c|
        h_export[p['Id']][c.json_name] = c.result(xml, p)
      end

      # Convert horrible unicode left and right quotes to universal single and double quotes
      # @TODO Remove this when possible, currently a Windows export issue
      h_export[p['Id']].each_pair do |k, v|
        if v.is_a? String
          h_export[p['Id']][k] = v.gsub(/[\u2018\u2019]/, "'").gsub(/[\u201c\u201d]/, '"')
        end
      end

      # Clean up results as to remove all null values (to save on file space)
      h_export[p['Id']].delete_if { |k, v| v.nil? or v == '' }
    end

    h_export
  end
end
