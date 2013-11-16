class Dialogue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :articy_draft
end
