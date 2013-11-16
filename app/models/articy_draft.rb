class ArticyDraft
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one :dialogue

  field :ref, type: String

  validates_presence_of :ref, :message => 'You must provide a valid XML file'

  def file_xml
    loc = Rails.root.to_s + '/' + AppConstants::ARTICY_DRAFT_DIR + '/' + self.ref
    file = File.open(loc)
    xml_content = Nokogiri::XML(file)
    file.close

    xml_content
  end
end
