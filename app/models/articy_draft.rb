class ArticyDraft
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ref, type: String

  validates_presence_of :ref, :message => 'You must provide a valid XML file'

  def file_xml
    loc = Rails.root + AppConstants::ARTICY_DRAFT_DIR + '/' + self.ref
    file = File.open(loc)
    xml_content = Nokogiri::XML(file)
    file.close

    xml_content
  end
end
