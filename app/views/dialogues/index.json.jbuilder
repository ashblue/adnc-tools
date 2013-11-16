json.array!(@dialogues) do |dialogue|
  json.extract! dialogue, 
  json.url dialogue_url(dialogue, format: :json)
end
