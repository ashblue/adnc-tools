class Dialogue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :articy_draft

  # @NOTE Would be amazing if I could build a system that allows you to choose the XML
  # attributes you want to pull in via a CMS
  def to_json
    xml = self.articy_draft.file_xml
    h_export = {}

    xml.xpath('//Condition').each do |c|
      h_export[c['Id']] = {
          :expression => c.xpath('.//Expression').inner_text,
          :connections => XmlHelpers::connectors(xml, c['Id']),
          :type => 'condition'
      }
    end

    xml.xpath('//Jump').each do |j|
      h_export[j['Id']] = {
          :connections => [j.at_xpath('.//Target').attribute('IdRef').to_s],
          :type => 'jump'
      }
    end

    xml.xpath('//Instruction').each do |s|
      h_export[s['Id']] = {
          :connections => XmlHelpers::connectors(xml, s['Id']),
          :expression => s.xpath('.//Expression').inner_text,
          :property_value => XmlHelpers::xattr(s, './/Boolean[@Name="PropertyValue"]', nil),
          :type => 'instruction'
      }
    end

    xml.xpath('//Hub').each do |h|
      h_export[h['Id']] = {
          :connections => XmlHelpers::connectors(xml, h['Id']),
          :type => 'hub',
          :title => h.at_xpath('.//DisplayName/LocalizedString').inner_text
      }
    end

    # @TODO At some point all exports should have a bookmark key
    # @TODO If a key is null, then don't include it
    xml.xpath('//Dialogue').each do |d|
      h_export[d['Id']] = {
          :text => XmlHelpers::xattr(d, './/Text/LocalizedString', nil),
          :character => XmlHelpers::xattr(d, './/References/Reference/@IdRef', nil),
          :connections => XmlHelpers::connectors(xml, d['Id']),
          :bookmark_id => XmlHelpers::xattr(d, './/NamedReference[@Name="Bookmark"]', 'IdRef'),
          :toggle_id => XmlHelpers::xattr(d, './/NamedReference[@Name="toggleId"]', 'IdRef'),
          :priority => XmlHelpers::xattr(d, './/Enum[@Name="Priority"]', nil),
          :single_use => XmlHelpers::xattr(d, './/Boolean[@Name="SingleUse"]', nil),
          :type => 'dialogue'
      }
    end

    h_export.to_json
  end
end
