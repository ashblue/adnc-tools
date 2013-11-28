json.array!(@tests) do |test|
  json.extract! test, :name
  json.url test_url(test, format: :json)
end
