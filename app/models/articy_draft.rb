class ArticyDraft
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :xml

  has_one :dialogue

  #validates_presence_of :ref, :message => 'You must provide a valid XML file'
  validates_attachment :xml,
                       :presence => true,
                       :content_type => { :content_type => 'text/xml' }

  def file_xml
    file = Paperclip.io_adapters.for(self.xml).read

    # Remove namespace in order to prevent XML namespace from gunking up searches
    Nokogiri::XML(file).remove_namespaces!
  end
end
