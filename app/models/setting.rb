class Setting
  include Mongoid::Document
  field :wrapper, type: String
  field :file_type, type: String
  field :write_location, type: String
end
