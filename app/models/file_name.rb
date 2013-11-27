class FileName
  include Mongoid::Document

  has_many :profiles

  field :name, type: String
  validates_presence_of :name
end
