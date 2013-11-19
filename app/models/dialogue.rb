class Dialogue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :articy_draft

  # @NOTE Would be amazing if I could build a system that allows you to choose the XML
  # attributes you want to pull in
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
      set_value = s.xpath('.//Boolean[@Name="PropertyValue"]')

      h_export[s['Id']] = {
          :connections => XmlHelpers::connectors(xml, s['Id']),
          :expression => s.xpath('.//Expression').inner_text,
          :type => 'instruction',
          :property_value => set_value.empty? ? nil : set_value.inner_text
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
    # @TODO Create a helper method that will parse out needed attributes from an xpath string
    # such as xattr('xpath string', 'attr opt, leave blank to return inner_text')
    xml.xpath('//Dialogue').each do |d|
      text = d.at_xpath('.//Text/LocalizedString')
      character = d.at_xpath('.//References/Reference/@IdRef')
      bookmark = d.xpath('.//NamedReference[@Name="Bookmark"]')
      toggle = d.xpath('.//NamedReference[@Name="toggleId"]')
      priority = d.xpath('.//Enum[@Name="Priority"]')
      single_use = d.xpath('.//Boolean[@Name="SingleUse"]')

      bookmark = bookmark.empty? ? nil : bookmark.attribute('IdRef').to_s
      toggle = toggle.empty? ? nil : toggle.attribute('IdRef').to_s

      h_export[d['Id']] = {
          :text => text.class == NilClass ? nil : text.inner_text,
          :character => character.class == NilClass ? nil : character.inner_text,
          :connections => XmlHelpers::connectors(xml, d['Id']),
          :bookmark_id => bookmark == '0x0000000000000000' ? nil : bookmark,
          :toggle_id => toggle == '0x0000000000000000' ? nil : toggle,
          :priority => priority.empty? ? nil : priority.inner_text,
          :single_use => single_use.empty? ? nil : single_use.inner_text,
          :type => 'dialogue'
      }
    end

    # @TODO Return all compiled XML components
    h_export.to_json
  end
end
