class Dialogue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :articy_draft

  # @NOTE Would be amazing if I could build a system that allows you to choose the XML
  # attributes you want to pull in
  def to_json
    xml = self.articy_draft.file_xml
    @dialogues = xml.xpath('//Dialogue')
    h_dialogues = {}

    # @TODO connectors xpath should only be called once
    @dialogues.each do |d|
      text = d.at_xpath('.//Text/LocalizedString')
      character = d.at_xpath('.//References/Reference/@IdRef')
      connectors = d.xpath('//Connection/Source[@IdRef="' + d['Id'] + '"]').map do |c|
        c.parent.xpath('.//Target').attribute('IdRef').to_s
      end

      h_dialogues[d['Id']] = {
          :text => text.class == NilClass ? '' : text.inner_text,
          :character => character.class == NilClass ? '' : character.inner_text,
          :connections => connectors
      }
    end

    h_dialogues.to_json
  end
end
