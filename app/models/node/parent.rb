class Node::Parent < Node::Base
  include Mongoid::Timestamps

  belongs_to :profile
  has_many :node_children, :class_name => 'Node::Child'

  field :key, type: String, default: './@Id' # Hash key used to store items

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
      key = p.xpath(self.key).inner_text

      h_export[key] = {}
      h_export[key][:type] = type.downcase if !type.nil?
      h_export[key][:template] = template.downcase if !template.nil?

      # for each node loop through all children with result
      self.node_children.each do |c|
        h_export[key][c.json_name] = c.result(xml, p)
      end

      # Convert horrible unicode left and right quotes to universal single and double quotes
      # @TODO Remove this when possible, currently a Windows export issue
      h_export[key].each_pair do |k, v|
        if v.is_a? String
          h_export[key][k] = v.gsub(/[\u2018\u2019]/, "'").gsub(/[\u201c\u201d]/, '"')
        end
      end

      # Clean up results as to remove all null values (to save on file space)
      h_export[key].delete_if { |k, v| v.nil? or v == '' }
    end

    h_export
  end
end
