class ArticyDraft
  include Mongoid::Document
  include Mongoid::Timestamps
  field :ref, type: String

  validates_presence_of :ref, :message => 'You must provide a valid XML file'
end
