json.array!(@settings) do |setting|
  json.extract! setting, :wrapper, :file_type
  json.url setting_url(setting, format: :json)
end
